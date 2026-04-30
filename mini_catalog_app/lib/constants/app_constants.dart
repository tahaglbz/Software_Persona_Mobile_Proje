/// Uygulamada kullanılacak tüm sabitler
/// NovaStore Mini Katalog Uygulaması
abstract class AppConstants {
  // Uygulama genel bilgileri
  static const String appName = 'NovaStore Mini Katalog';
  static const String appVersion = '1.0.0';
  static const String appSubtitle = 'En İyi Ürünleri Keşfedin';

  // API Ayarları
  static const String baseApiUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '$baseApiUrl/products';

  // Renkler
  static const String primaryColor = '#1976D2'; // Material Blue
  static const String accentColor = '#FF5722'; // Material Deep Orange
  static const String backgroundColor = '#FFFFFF';
  static const String textColor = '#212121';
  static const String lightGrayColor = '#F5F5F5';
  static const String successColor = '#4CAF50'; // Yeşil (başarı)

  // Font boyutları
  static const double fontSizeLarge = 28.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeSmall = 14.0;
  static const double fontSizeXSmall = 12.0;

  // Padding ve Margin
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Asset yolları
  static const String bannerPath = 'assets/banners/banner.png';
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';

  // Diğer ayarlar
  static const int connectTimeout = 30; // saniye
  static const int readTimeout = 30; // saniye
}

/// Ürün ile ilgili sabitler
abstract class ProductConstants {
  static const int gridColumnsCount = 2; // 2 sütunlu grid
  static const double gridSpacing = 16.0;
  static const double productImageHeight = 200.0;
}

/// Metin sabitleri (Türkçe UI)
abstract class TextStrings {
  // Ana ekran
  static const String homeTitle = 'Hoş Geldiniz';
  static const String selectProductText = 'Ürünü seçerek detaylarını görebilirsiniz';
  static const String loadingText = 'Ürünler yükleniyor...';
  static const String errorText = 'Hata oluştu. Lütfen tekrar deneyiniz.';
  static const String retryText = 'Tekrar Dene';
  static const String noProductsText = 'Ürün bulunamadı';

  // Detay ekranı
  static const String productDetailsTitle = 'Ürün Detayı';
  static const String addToCartText = 'Sepete Ekle';
  static const String addedToCartText = '✓ Ürün sepete eklendi!';
  static const String priceText = 'Fiyat';
  static const String categoryText = 'Kategori';
  static const String descriptionText = 'Açıklama';
  static const String ratingText = 'Puan';
  static const String reviewCountText = 'yorumlar';

  // Hata mesajları
  static const String networkErrorText = 'İnternet bağlantısını kontrol edin';
  static const String timeoutErrorText = 'Zaman aşımı. Lütfen tekrar deneyiniz.';
  static const String unknownErrorText = 'Bilinmeyen bir hata oluştu';
}
