# NovaStore Mini Katalog

Kısa Açıklama

- NovaStore Mini Katalog, FakeStore API'den ürünleri listeleyen, detaylarını gösteren ve basit bir in-memory sepet sistemi sunan eğitim amaçlı bir Flutter uygulamasıdır.

Kullanılan / Önerilen Flutter / Dart Sürümü

- `pubspec.yaml` içindeki Dart SDK kısıtlaması: `sdk: '>=3.0.0 <4.0.0'`.
- Önerilen: Flutter stable kanalı, Flutter 3.x veya üzeri (Dart 3 uyumlu). Mevcut makinedeki sürümü görmek için:

```bash
flutter --version
```

Çalıştırma Adımları

1. Depoyu klonlayın veya proje klasörüne gidin:

```bash
cd /Users/tahagulbaz/Documents/GitHub/Software_Persona_Mobile_Proje/mini_catalog_app
```

2. Gerekli paketleri yükleyin:

```bash
flutter pub get
```

3. iOS Simulator veya Android Emulator açın (veya cihazınızı bağlayın), sonra uygulamayı çalıştırın:

```bash
flutter run -d <DEVICE_ID>
```

Cihaz listesini görmek için:

```bash
flutter devices
```

4. Uygulamayı derlemek (release):

- Android:

```bash
flutter build apk --release
```

- iOS (macOS gereklidir):

```bash
flutter build ios --release
```

Hata Yakalama / Debug İpuçları

- Uygulama çalışırken konsolda detaylı log almak için:

```bash
flutter run -d <DEVICE_ID> --verbose > run_log.txt 2>&1
```

- Sık karşılaşılan layout/RenderBox sorunları genelde `Flexible`/`Expanded` kullanımından veya bir `ListView`/`Column` içinde sınırlandırılmamış widget'lardan kaynaklanır.

Proje Yapısı (Kısa)

- `lib/main.dart` — Uygulama giriş noktası.
- `lib/screens/` — Ekranlar (Home, Detail, Cart vb.).
- `lib/widgets/` — Yeniden kullanılabilir widget'lar.
- `lib/services/cart_service.dart` — Basit in-memory sepet servisi.
- `lib/models/product.dart` — Ürün veri modeli.


![Ana Ekran](/mini_catalog_app/assets/readmess/anaekran.png)
![Ürün Detay](/mini_catalog_app/assets/readmess/urundetay.png)
![Ürün Detay 2](/mini_catalog_app/assets/readmess/urundetay2.png)
![Sepet](/mini_catalog_app/assets/readmess/sepet.png)