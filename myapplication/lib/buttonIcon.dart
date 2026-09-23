// Removed buttons => Their Replacements
// FlatButton => TextButton
// RaisedButton => ElevatedButton
// OutlineButton => OutlinedButton

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: ButtonIconPage(),
));

class ButtonIconPage extends StatelessWidget {
  const ButtonIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buttons & Icons'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(
          onPressed: () {
            print('You clicked me');
          },
          icon: Icon(
            Icons.alternate_email,
          ),
          color: Colors.amber,
        ),
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: Icon(
        //       Icons.mail
        //   ),
        //   label: Text('mail me'),
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor:Colors.amber,
        //       foregroundColor:Colors.black,
        //   ),
        // ),
        // TextButton(
        //   onPressed: (){
        //     print('you clicked me');
        //   },
        //   style: TextButton.styleFrom(
        //     backgroundColor: Colors.deepPurple,
        //     foregroundColor: Colors.black,
        //   ),
        //   child: Text('Click man')
        // )
        // ElevatedButton(
        //   onPressed: (){},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.lightBlue,
        //     foregroundColor: Colors.black,
        //   ),
        //   child: Text('Click yo'),
        // ),
        // Icon(
        //   Icons.airport_shuttle,
        //   color: Colors.lightBlue,
        //   size: 50.0,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: Text('Click bruh', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
