//Encapsulation Concept

class Camera {
  // Private properties (denoted by the underscore _)
  int? _id;
  String? _brand;
  String? _color;
  double? _price;

  // Idiomatic Dart Getters
  int get id => _id!;
  String get brand => _brand!;
  String get color => _color!;
  double get price => _price!;

  // Idiomatic Dart Setters
  set id(int id) => _id = id;
  set brand(String brand) => _brand = brand;
  set color(String color) => _color = color;
  set price(double price) => _price = price;

  // Helper method to print details easily
  void display() {
    print('Camera ID: $id');
    print('Brand: $brand');
    print('Color: $color');
    print('Price: \$$price');
    print('--------------------');
  }
}

void main() {
  // Create object 1
  Camera cam1 = Camera();
  cam1.id = 1;
  cam1.brand = 'Canon';
  cam1.color = 'Black';
  cam1.price = 599.99;

  // Create object 2
  Camera cam2 = Camera();
  cam2.id = 2;
  cam2.brand = 'Sony';
  cam2.color = 'Silver';
  cam2.price = 899.50;

  // Create object 3
  Camera cam3 = Camera();
  cam3.id = 3;
  cam3.brand = 'Nikon';
  cam3.color = 'Red';
  cam3.price = 450.00;

  // Print all details
  print('--- CAMERA INVENTORY ---');
  cam1.display();
  cam2.display();
  cam3.display();
}
