import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: ImagesPage()
));

class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        centerTitle: true,
        backgroundColor: Colors.blue[50],
      ),
      body: Center(
        child:Image.asset('assets/space-1.jpg'), //Image.network('https://images.unsplash.com/photo-1505506874110-6a7a69069a08?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        // Image(
        //   // image: NetworkImage('https://images.unsplash.com/photo-1505506874110-6a7a69069a08?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        //   // image:AssetImage('assets/space-3.jpg'),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[50],
        child:Text('click'),
      ),
    );
  }
}
