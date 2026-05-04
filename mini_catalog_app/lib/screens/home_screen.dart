import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../constants/app_constants.dart';
import '../widgets/product_grid_card.dart';
import '../services/cart_service.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

/// Ana Sayfa - Day 5: GridView.builder ile ürün kataloğu
/// Ürünleri FakeStore API'den gerçek zamanlı yükler
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;
  final CartService cartService = CartService();

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
        actions: [
          // Sepet İkonu
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.paddingMedium),
            child: Center(
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () async {
                      try {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                        setState(() {});
                      } catch (e, st) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Sepet açılamadı: ${e.toString()}')),
                        );
                        // ignore: avoid_print
                        print('Cart navigation error: $e\n$st');
                      }
                    },
                  ),
                  // Sepet sayacı
                  if (cartService.itemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${cartService.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Banner Alanı
            _buildBannerSection(context),
            // Ürün Gridı
            Expanded(
              child: _buildProductGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// Banner Bölümü - Responsive Design
  Widget _buildBannerSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Ekran genişliğine göre banner yüksekliğini ayarla
        final bannerHeight =
            constraints.maxWidth * 0.05; // Ekran genişliğinin %35'i

        return Container(
          width: double.infinity,
          height: bannerHeight.clamp(120, 180),
          margin: const EdgeInsets.all(AppConstants.paddingMedium),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppConstants.bannerPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blue.shade50,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.blue.shade300,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            'Banner bulunamadı',
                            style: TextStyle(
                              color: Colors.blue.shade300,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
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
                Flexible(
                  child: Text(
                    TextStrings.loadingText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Hata durumu
        if (snapshot.hasError) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        TextStrings.errorText,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                onTap: () async {
                  // Navigate to detail screen with error handling to avoid crashes
                  try {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          product: product,
                        ),
                      ),
                    );
                    // Update state after returning
                    setState(() {});
                  } catch (e, st) {
                    // Show non-fatal error and log stack trace for debugging
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Hata: ${e.toString()}')),
                    );
                    // Print to console for developer inspection
                    // ignore: avoid_print
                    print('Navigation error: $e\n$st');
                  }
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
