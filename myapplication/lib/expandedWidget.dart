import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home:expandedPages(),
));

class expandedPages extends StatelessWidget {
  const expandedPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Widgets'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Row(
        children: <Widget>[
          Expanded(child: Image.asset('assets/space-1.jpg'),
          flex:3,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:EdgeInsets.all(30.0),
              color: Colors.pinkAccent,
              child: Text('1')
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber,
              child: Text('2'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.cyan,
              child:Text('3'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.teal,
        child: Text('Click', style:TextStyle(
          color:Colors.black,
        ),),
      ),
    );
  }
}
