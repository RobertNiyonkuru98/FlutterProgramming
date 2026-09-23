import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home:containerPage(),
));

class containerPage extends StatelessWidget {
  const containerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Layout'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
          padding: EdgeInsets.all(90.0),
          child:Text('Hello'),
      ),
      // Container(
      //   padding:
      //   // EdgeInsets.all(20.0), // same padding for all directinos
      //   // EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0), //padding generalised for horiz and vertic
      //   EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0), // Padding for 4 directions
      //   margin:EdgeInsets.all(30.0),
      //   color: Colors.grey[400],
      //   child: Text('Hello'),
      // ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.amber,
          child: Text('click'),
      ),
    );
  }
}
