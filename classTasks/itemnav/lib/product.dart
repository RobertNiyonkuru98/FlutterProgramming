import 'package:flutter/material.dart';

// A simple class to hold the data for each product
class Product {
  final String title;
  final String displayTitle;
  final String description;
  final int price;
  final Color color;
  final bool hasSolidStars;

  Product({
    required this.title,
    required this.displayTitle,
    required this.description,
    required this.price,
    required this.color,
    this.hasSolidStars = false,
  });
}

// A function to get our list of dummy products matching the image
List<Product> getProducts() {
  return [
    Product(
      title: 'Pixel',
      displayTitle: 'pixel 1',
      description: 'Pixel is the most featureful phone ever',
      price: 800,
      color: Colors.blue[600]!,
    ),
    Product(
      title: 'Laptop',
      displayTitle: 'laptop',
      description: 'Laptop is most productive development tool',
      price: 2000,
      color: Colors.green[500]!,
    ),
    Product(
      title: 'Tablet',
      displayTitle: 'tablet',
      description: 'Tablet is the most useful device ever for meeting',
      price: 1500,
      color: Colors.yellow[700]!,
      hasSolidStars: true, // The image shows solid red stars for the tablet!
    ),
    Product(
      title: 'Pendrive',
      displayTitle: 'pen drive',
      description: 'iPhone is the stylist phone ever', // Kept exactly as it is in the picture!
      price: 100,
      color: Colors.brown[400]!,
    ),
    Product(
      title: 'Floppy Drive',
      displayTitle: 'floppy drive',
      description: 'iPhone is the stylist phone ever',
      price: 20,
      color: Colors.teal[300]!,
    ),
  ];
}
