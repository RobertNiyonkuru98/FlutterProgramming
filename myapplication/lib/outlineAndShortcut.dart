import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: outlinePages(),
));

class outlinePages extends StatelessWidget {
  const outlinePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outline and Shortcuts'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.cyan,
            child: Text('one'),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.pink,
            child:Text('two'),
          ),
          Row(
            children: <Widget>[
              Text('Hello'),
              Text('World'),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
        backgroundColor: Colors.greenAccent,
        child:Text('Click', style:TextStyle(
          color:Colors.black,
        ),),
      ),
    );
  }
}
