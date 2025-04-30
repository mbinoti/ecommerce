import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product.image ?? '',
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.title ?? '',
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              product.price != null
                  ? '\$${product.price!.toStringAsFixed(0)}'
                  : '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            if (product.originalPrice != null)
              Text(
                '\$${product.originalPrice!.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
