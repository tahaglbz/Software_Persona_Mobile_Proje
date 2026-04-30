# 📱 Mini Katalog Uygulaması - Proje Yapısı

## 📂 Klasör Hiyerarşisi

```
mini_catalog_app/
├── lib/
│   ├── main.dart                 # Uygulamanın giriş noktası
│   ├── screens/                  # Ekranlar (sayfalar)
│   │   ├── home_screen.dart      # Ana sayfa
│   │   ├── product_list_screen.dart # Ürün listesi
│   │   └── product_detail_screen.dart # Ürün detayı
│   ├── widgets/                  # Yeniden kullanılabilir bileşenler
│   │   ├── product_card.dart     # Ürün kartı widget'ı
│   │   ├── custom_appbar.dart    # Özel AppBar
│   │   └── product_grid.dart     # Ürün grid layout'ı
│   ├── models/                   # Veri modelleri
│   │   └── product.dart          # Ürün modeli (JSON serialization ile)
│   └── constants/                # Sabitler (opsiyonel)
│       └── app_constants.dart    # Uygulamaya ait sabitler
│
├── assets/
│   ├── banners/                  # Banner görselleri
│   │   └── banner.png            # Ana banner
│   ├── images/                   # Ürün görselleri
│   └── icons/                    # Özel ikonlar
│
├── pubspec.yaml                  # Proje bağımlılıkları ve konfigürasyonu
└── README.md                      # Proje dokümantasyonu
```

## 🎯 Klasörlerin Amacı

### **lib/main.dart**
- Uygulamanın başlangıç dosyası
- `main()` fonksiyonu burada tanımlanır
- `MaterialApp` konfigürasyonu yapılır

### **lib/screens/**
Uygulamanın her ekranı için bir Stateless/Stateful widget
- `HomeScreen` - Ana sayfa
- `ProductListScreen` - Ürün listesi (Day 2-3)
- `ProductDetailScreen` - Ürün detayı (Day 4)

### **lib/widgets/**
Birden fazla yerde kullanılacak küçük bileşenler
- `ProductCard` - Ürün kartı (Day 5)
- `CustomAppBar` - Özel AppBar
- `ProductGrid` - Grid layout (Day 5)

### **lib/models/**
Veri modelleri ve JSON serialization
- `Product` sınıfı (Day 4)
  - ürün adı, fiyat, açıklama
  - `fromJson()` ve `toJson()` metodları

### **assets/**
Statik dosyalar
- **banners/**: Banner görselleri
- **images/**: Ürün görselleri
- **icons/**: Özel ikonlar (Material Icons yerine)

## 📋 pubspec.yaml Açıklaması

```yaml
name: mini_catalog_app
description: Mini Katalog Uygulaması
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'  # Dart versiyonu

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2  # iOS ikonları

flutter:
  uses-material-design: true
  
  assets:
    - assets/banners/     # Bu dosyalar içinde kullanabiliriz
    - assets/images/
    - assets/icons/
```

**Önemli**: Assets ekledikten sonra `flutter pub get` çalıştırmalısın!

## 🚀 Çalıştırma Adımları (iOS Simulator)

1. **Proje dosyasında aç**:
   ```bash
   cd /Users/tahagulbaz/Documents/GitHub/Software_Persona_Mobile_Proje/mini_catalog_app
   flutter pub get
   ```

2. **iOS Simulator başlat**:
   ```bash
   open -a Simulator
   ```

3. **Uygulamayı çalıştır**:
   ```bash
   flutter run
   ```

4. **Hot Reload kullan** (Değişiklikleri anında gör):
   - Kodu değiştir
   - Terminal'de `r` tuşuna bas

5. **Tamamen yeniden başlat**:
   - Terminal'de `R` tuşuna bas (capital R)

## 📌 Stateless vs Stateful Widget

### **Stateless Widget**
- State'i (durumu) değişmeyen UI bileşenleri
- `build()` metodu biriktir
- Örnek: Başlık, metin, ikon

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Button(child: Text('Tıkla'));
  }
}
```

### **Stateful Widget**
- State'i (durumu) değişebilen UI bileşenleri
- `build()` metodu StateClass'ta
- `setState()` ile UI yeniden çizilir
- Örnek: Counter, Form, Toggle

```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}
```

## ✅ Day 1 Kontrol Listesi

- [x] Proje klasör yapısı oluşturuldu
- [x] `pubspec.yaml` konfigüre edildi
- [x] `lib/main.dart` başlangıç kodu yazıldı
- [x] `lib/screens/`, `lib/widgets/`, `lib/models/` klasörleri oluşturuldu
- [x] `assets/` klasörleri (banners, images, icons) oluşturuldu
- [ ] Komutu çalıştır: `flutter pub get`
- [ ] iOS Simulator'da test et: `flutter run`

---

**Sonraki**: Day 2'de Layout (Row, Column, Card, Container) öğreneceğiz!
