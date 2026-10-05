import 'package:flutter/material.dart';
import 'product.dart';
import 'product_details.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get our list of products
    final products = getProducts();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Navigation'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // Use ListView.builder for repeating items
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          
          return GestureDetector(
            onTap: () {
              // When tapped, navigate to the Details screen and pass the product data!
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: IntrinsicHeight( // Forces the Row to be as tall as its tallest child
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LEFT SIDE: Colored Box
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: product.color,
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            product.displayTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // RIGHT SIDE: Details
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: ${product.price}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Spacer(),
                            // The 3 stars
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) => Icon(
                                product.hasSolidStars ? Icons.star : Icons.star_border,
                                color: Colors.redAccent,
                                size: 16,
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
