import 'package:flutter/material.dart';
import '../models/product.dart';
import '../constants/app_constants.dart';
import '../services/cart_service.dart';

/// Ürün Detay Ekranı - Day 3: MaterialPageRoute Navigation
/// Ürün bilgilerini detaylı gösterir ve "Sepete Ekle" işlemi
class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late CartService cartService;
  int cartQuantity = 0;

  @override
  void initState() {
    super.initState();
    cartService = CartService();
    cartQuantity = cartService.getQuantity(widget.product.id);
  }

  /// "Sepete Ekle" butonuna tıklandığında çalışan metod
  void _addToCart() {
    cartService.addItem(widget.product);
    cartQuantity = cartService.getQuantity(widget.product.id);

    // Snackbar ile kullanıcıya bilgi ver
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.title} ${TextStrings.addedToCartText}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppConstants.paddingMedium),
      ),
    );

    // State'i güncelle
    setState(() {
      cartQuantity = cartService.getQuantity(widget.product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextStrings.productDetailsTitle),
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ürün Görseli
              _buildProductImage(),
              // Ürün Bilgileri
              _buildProductInfo(),
              // Kategori
              _buildCategoryBadge(),
              // Açıklama
              _buildDescriptionSection(),
              // Derecelendirme
              if (widget.product.rating != null) _buildRatingSection(),
              // Boşluk
              const SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
      // "Sepete Ekle" Buton
      bottomNavigationBar: _buildAddToCartButton(),
    );
  }

  /// Ürün Görseli Bölümü
  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey.shade100,
      child: widget.product.image.isNotEmpty
          ? Image.network(
              widget.product.image,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Görsel yüklenemedi',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Icon(
                Icons.shopping_bag,
                size: 80,
                color: Colors.blue.shade300,
              ),
            ),
    );
  }

  /// Ürün Adı ve Fiyat
  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ürün Adı
          Text(
            widget.product.title,
            style: const TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          // Fiyat
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    '${TextStrings.priceText}:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '₺${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Kategori Etiketi
  Widget _buildCategoryBadge() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: Chip(
        label: Text(
          widget.product.category.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.blue.shade600,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
      ),
    );
  }

  /// Açıklama Bölümü
  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            TextStrings.descriptionText,
            style: TextStyle(
              fontSize: AppConstants.fontSizeMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              widget.product.description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Derecelendirme Bölümü
  Widget _buildRatingSection() {
    final rating = widget.product.rating;
    if (rating == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Yıldız Puanı
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        rating.rate.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber.shade600,
                        size: 24,
                      ),
                    ],
                  ),
                  Text(
                    '${rating.count} ${TextStrings.reviewCountText}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              // Yıldız Gösterimi
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.rate.floor()
                          ? Icons.star_rounded
                          : index < rating.rate
                              ? Icons.star_half_rounded
                              : Icons.star_outline_rounded,
                      color: Colors.amber.shade600,
                      size: 20,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// "Sepete Ekle" Buton
  Widget _buildAddToCartButton() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: ElevatedButton(
          onPressed: _addToCart,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.paddingLarge,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_rounded, size: 24),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  TextStrings.addToCartText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (cartQuantity > 0) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$cartQuantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
