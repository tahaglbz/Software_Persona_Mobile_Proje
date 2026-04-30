import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../constants/app_constants.dart';
import '../widgets/product_grid_card.dart';
import 'detail_screen.dart';

/// Ana Sayfa - Day 5: GridView.builder ile ürün kataloğu
/// Ürünleri FakeStore API'den gerçek zamanlı yükler
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  /// FakeStore API'den ürünleri çeker
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse(AppConstants.productsEndpoint))
          .timeout(const Duration(seconds: AppConstants.connectTimeout));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception(TextStrings.networkErrorText);
      }
    } catch (e) {
      throw Exception('Hata: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppConstants.appSubtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        elevation: 2,
        backgroundColor: Colors.blue.shade700,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Banner Alanı
            _buildBannerSection(),
            // Ürün Gridı
            Expanded(
              child: _buildProductGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// Banner Bölümü
  Widget _buildBannerSection() {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          AppConstants.bannerPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported,
                      size: 40, color: Colors.blue.shade300),
                  const SizedBox(height: 8),
                  Text(
                    'Banner bulunamadı',
                    style: TextStyle(color: Colors.blue.shade300),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Ürün Grid'i (Day 5: GridView.builder)
  Widget _buildProductGrid() {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        // Yükleniyor durumu
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  TextStrings.loadingText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        // Hata durumu
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  TextStrings.errorText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      futureProducts = fetchProducts();
                    });
                  },
                  child: const Text(TextStrings.retryText),
                ),
              ],
            ),
          );
        }

        // Veri yüklenmiş
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
              vertical: AppConstants.paddingSmall,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ProductConstants.gridColumnsCount,
              childAspectRatio: 0.65,
              crossAxisSpacing: ProductConstants.gridSpacing,
              mainAxisSpacing: ProductConstants.gridSpacing,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductGridCard(
                product: product,
                onTap: () {
                  // Day 3: Navigation ile ürün detayına git
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        product: product,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }

        // Ürün bulunamadı
        return Center(
          child: Text(
            TextStrings.noProductsText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
