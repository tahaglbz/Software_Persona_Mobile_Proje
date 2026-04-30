# 🍎 iOS Simulator'da Mini Katalog Uygulaması Çalıştırma Rehberi

## 📱 iOS Simulator Nedir?

iOS Simulator, Mac bilgisayarda iPhone ve iPad'i simüle eden Apple'ın resmi aracıdır. Flutter uygulamalarının iOS platformunda nasıl görüneceğini test etmemize olanak tanır.

## ✅ Ön Koşullar

- ✅ **macOS**: Herhangi bir son sürüm (Monterey veya üzeri önerilir)
- ✅ **Xcode**: App Store'dan indir
- ✅ **Flutter**: Yüklü ve PATH'e eklenen
- ✅ **Terminal**: iTerm2 veya Apple Terminal

## 🚀 Adım Adım Kurulum

### **1. Adım: Xcode Komut Satırı Araçlarını Yükle**

```bash
xcode-select --install
```

Ya da Xcode'u tamamen yükle:
```bash
xcode-select --reset
```

### **2. Adım: Flutter'ın iOS'u Destekledikten Doğrula**

```bash
cd /Users/tahagulbaz/Documents/GitHub/Software_Persona_Mobile_Proje/mini_catalog_app

flutter doctor
```

Beklediğin çıktı:
```
✓ Flutter (version 3.x.x)
✓ iOS toolchain - develop for iOS devices
✓ Xcode - develop for iOS and macOS
✓ CocoaPods
```

Eğer bazı ✗ (işaret) gördüysen, sorunları düzeltmek için:
```bash
flutter doctor --verbose
```

### **3. Adım: iOS Simulator Başlat**

**Seçenek A - Komut Satırından:**
```bash
open -a Simulator
```

**Seçenek B - Finder'dan:**
1. Finder → Applications
2. Utilities → Simulator

**Seçenek C - Xcode'dan:**
1. Xcode aç
2. Xcode → Open Developer Tool → Simulator

### **4. Adım: Uygun iPhone Cihazını Seç**

Simulator menüsü → Device → iPhone 15 Pro (önerilir)

İOS sürümü: **iOS 17.x** (güncel olmayan olabilir)

### **5. Adım: Uygulamayı Çalıştır**

Proje klasöründe terminal aç:

```bash
cd /Users/tahagulbaz/Documents/GitHub/Software_Persona_Mobile_Proje/mini_catalog_app
flutter run
```

**Beklediğin çıktı:**
```
Launching lib/main.dart on iPhone 15 Pro in debug mode...
Xcode build done. (28.7s)
App running.

Run with flutter run -v for more options.
```

### **6. Adım: Hot Reload'u Kullan**

Terminal penceresinde iken:

- **r** tuşuna bas → **Hot Reload** (kod değişiklikleri 0.5-1 saniyede görünür)
- **R** tuşuna bas → **Full Restart** (tamamen yeniden başlat)
- **q** tuşuna bas → Çıkış

## 🎨 iOS Simulator'da Uygulama Tasarımı

### **Simulator Hakkında Bilinmesi Gerekenler**

1. **Notch (çentiğin) Bulunabilir**
   - iPhone 14 Pro / 15 Pro
   - Tasarımda `SafeArea` widget'ı kullandık, sorun yoktur

2. **Durum Çubuğu**
   - Üst kısımda WiFi, pil bilgisi
   - `SafeArea` otomatik olarak bu alanı atlıyor

3. **Home Indicator**
   - Alt tarafta (iPhone X+)
   - Tasarımımız bunu göz önünde tutuyor

4. **Responsive Tasarım**
   - Uygulamız farklı ekran boyutları ile otomatik uyum sağlıyor
   - Material Design 3 kullandığımız için tutarlı görünen

### **Ekran Boyutları (Simulatörde Test Et)**

| Cihaz | Boyut | Kullanım |
|-------|-------|---------|
| iPhone 15 Pro | 6.1" | En yaygın |
| iPhone 15 Plus | 6.7" | Büyük ekran |
| iPhone SE | 4.7" | Kompakt |
| iPad Air | 10.9" | Tablet |

## 🔧 Sorun Giderme

### **Sorun: "flutter doctor" Xcode uyarısı gösteriyor**

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### **Sorun: CocoaPods hatası**

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter run
```

### **Sorun: "Unable to boot simulator"**

```bash
xcrun simctl erase all
xcrun simctl create iPhone15Pro com.apple.CoreSimulator.SimDeviceType.iPhone-15-Pro com.apple.CoreSimulator.SimRuntime.iOS-17-2
```

### **Sorun: iOS Simulator'u Kapatamıyorum**

```bash
# Simulator processini bitir
killall "Simulator"
```

## 📊 Simulator Performans İpuçları

1. **RAM Kullanımını Azalt:**
   - Gerekmeyen uygulamaları simulatörde kapatın
   - Mac'ta arka planda çalışan uygulamaları kapatın

2. **Hızlı Geliştirme:**
   - Hot Reload kullanın (r tuşu)
   - Full Restart (R tuşu) nadiren kullanın

3. **Debugging:**
   ```bash
   flutter run -v  # Verbose çıktı
   flutter logs    # Uygulama loglarını gör
   ```

## 🎯 İlk Çalıştırma Kontrol Listesi

- [ ] Xcode yüklü ve güncellendi
- [ ] `flutter doctor` tüm kontroller yeşil
- [ ] iOS Simulator açılıyor (`open -a Simulator`)
- [ ] Terminal'den `flutter run` başlatılıyor
- [ ] Uygulama Simulator'da açılıyor
- [ ] "Hoş Geldiniz!" başlığını görebiliyoruz
- [ ] "Ürünleri Gör" butonu tıklanabiliyor
- [ ] r tuşu ile Hot Reload çalışıyor

---

**Sıradaki İşlem:**

1. Terminal'de şu komutları çalıştır:
   ```bash
   cd /Users/tahagulbaz/Documents/GitHub/Software_Persona_Mobile_Proje/mini_catalog_app
   flutter pub get
   open -a Simulator
   flutter run
   ```

2. Uygulamayı Simulator'da gör
3. "Day 1 is done" mesajını yaz ve devam edelim!

---

**Faydalı Kaynaklar:**
- [Flutter iOS Setup](https://docs.flutter.dev/get-started/install/macos)
- [Flutter Hot Reload](https://docs.flutter.dev/development/tools/hot-reload)
- [iOS Simulator Documentation](https://help.apple.com/simulator/mac/current/)
