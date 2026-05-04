import '../models/product.dart';

/// Cart Service - Basit ve eğitimsel amaçlı sepet yönetimi
/// Singleton pattern kullanarak uygulama genelinde erişilebilir
class CartService {
  static final CartService _instance = CartService._internal();

  final List<CartItem> _items = [];

  CartService._internal();

  factory CartService() {
    return _instance;
  }

  /// Sepetteki ürünleri döndür
  List<CartItem> get items => List.unmodifiable(_items);

  /// Sepetteki toplam ürün sayısı
  int get itemCount => _items.length;

  /// Sepetteki toplam fiyat
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Ürünü sepete ekle
  void addItem(Product product) {
    // Aynı ürün varsa miktarını artır
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
      // ignore: avoid_print
      print(
          'CartService: incremented ${product.title} to ${existingItem.quantity}');
    } else {
      _items.add(CartItem(product: product, quantity: 1));
      // ignore: avoid_print
      print('CartService: added ${product.title}');
    }
  }

  /// Ürünü sepetten kaldır
  void removeItem(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    // ignore: avoid_print
    print('CartService: removed product id $productId');
  }

  /// Ürünün miktarını güncelle
  void updateQuantity(int productId, int quantity) {
    try {
      final item = _items.firstWhere((item) => item.product.id == productId);
      if (quantity <= 0) {
        removeItem(productId);
      } else {
        item.quantity = quantity;
        // ignore: avoid_print
        print('CartService: updated product $productId quantity -> $quantity');
      }
    } catch (e) {
      // Ürün bulunamadı
      // ignore: avoid_print
      print('CartService: updateQuantity failed for $productId');
    }
  }

  /// Sepeti boşalt
  void clear() {
    _items.clear();
    // ignore: avoid_print
    print('CartService: cleared');
  }

  /// Belirli bir ürün sepette var mı?
  bool containsProduct(int productId) {
    return _items.any((item) => item.product.id == productId);
  }

  /// Ürünün miktarını döndür
  int getQuantity(int productId) {
    try {
      return _items.firstWhere((item) => item.product.id == productId).quantity;
    } catch (e) {
      return 0;
    }
  }
}

/// Sepet ürünü - Product ve quantity bilgisini tutar
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  /// Ürünün toplam fiyatı (quantity * price)
  double get totalPrice => product.price * quantity;

  @override
  String toString() =>
      'CartItem(product: ${product.title}, quantity: $quantity, total: $totalPrice)';
}
