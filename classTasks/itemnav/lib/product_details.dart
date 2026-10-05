import 'package:flutter/material.dart';
import 'product.dart';

class ProductDetailsScreen extends StatelessWidget {
  // We require a Product object to be passed in when this screen is created!
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // TOP HALF: Large Colored Section
          Container(
            width: double.infinity,
            height: 250,
            color: product.color,
            child: Center(
              child: Text(
                product.displayTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          // BOTTOM HALF: Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Price: ${product.price}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  // Stars aligned to the bottom right
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) => Icon(
                        product.hasSolidStars ? Icons.star : Icons.star_border,
                        color: Colors.redAccent,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
