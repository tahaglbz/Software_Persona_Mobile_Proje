import 'package:flutter/material.dart';
import '../models/product.dart';
import '../constants/app_constants.dart';

/// Ürün Grid Kartı - Day 5: GridView için özel widget
/// Her bir ürünü grid'de göstermek için tasarlandı
class ProductGridCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductGridCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProductGridCard> createState() => _ProductGridCardState();
}

class _ProductGridCardState extends State<ProductGridCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Card(
          elevation: _isHovered ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ürün Görseli
                _buildProductImage(),
                // Ürün Bilgileri
                _buildProductInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Ürün Görselini Gösteren Bölüm
  Widget _buildProductImage() {
    return Container(
      height: ProductConstants.productImageHeight * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Görsel
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
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
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 40,
                      color: Colors.blue.shade300,
                    ),
                  ),
          ),
          // Overlay Hover Efekti
          if (_isHovered)
            Container(
              color: Colors.black.withOpacity(0.1),
            ),
        ],
      ),
    );
  }

  /// Ürün Bilgileri Bölümü
  Widget _buildProductInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kategori
            Chip(
              label: Text(
                widget.product.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(height: 6),
            // Ürün Adı
            Text(
              widget.product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // Derecelendirme (eğer varsa)
            if (widget.product.rating != null)
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Colors.amber.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.product.rating!.rate.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    ' (${widget.product.rating!.count})',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            const Spacer(),
            // Fiyat
            Text(
              '₺${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
