import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: rowPage(),
));

class rowPage extends StatelessWidget {
  const rowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Rows'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.center, //middle alignment
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, //space between the widgets
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // like spacebetween but we get space at the left and right of the screen
        // mainAxisAlignment: MainAxisAlignment.end, // aligns them at the end right screen
        // mainAxisAlignment: MainAxisAlignment.spaceAround, // like spaceevenly but doubled space between the widgets and the sides

        //crossAxisAlignment: CrossAxisAlignment.stretch,
        // crossAxisAlignment: CrossAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,


        children: <Widget>[

          Text('Hello World'),

          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.black,
              ),
            child: Text('Click me'),
          ),

          Container(
            color: Colors.cyan,
            padding:EdgeInsets.all(30.0),
            child:Text('inside container'),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.deepOrange,
        child: Text('Click'),
      ),
    );
  }
}
