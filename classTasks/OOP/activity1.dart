// Constructor concept

class Book {
  String name;
  String author;
  int price;

  Book(this.name, this.author, this.price);

  void display() {
    print('--- Book Details ---');
    print('Name: $name');
    print('Author: $author');
    print('Year Published: $price');
    print('--------------------');
  }
}

void main() {
  Book book1 = Book('1984', 'George Orwell', 1949);

  book1.display();
}
