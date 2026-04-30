/// Ürün veri modeli - NovaStore Mini Katalog Uygulaması
/// FakeStore API'den veri almak için tasarlanmıştır
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    this.rating,
  });

  /// JSON'dan ürün nesnesine dönüştürme (Day 4: Model Logic)
  /// FakeStore API formatından veri alır
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Bilinmeyen Ürün',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      category: json['category'] as String? ?? 'Genel',
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
      'rating': rating?.toJson(),
    };
  }

  @override
  String toString() => 'Product(id: $id, title: $title, price: ₺$price)';
}

/// Ürün derecelendirmesi - Rating bilgileri
class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
