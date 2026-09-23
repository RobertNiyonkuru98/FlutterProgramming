import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home:columnPages(),
));

class columnPages extends StatelessWidget {
  const columnPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Columns'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body:Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.cyan,
          child: Text('One'),
        ),

        Container(
          padding: EdgeInsets.all(30.0),
          color: Colors.pink,
          child: Text('Two'),
        ),

        Container(
          padding: EdgeInsets.all(40.0),
          color: Colors.amber,
          child: Text('Three'),
        ),

      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.green,
        child: Text('Click'),
      ),
    );
  }
}
