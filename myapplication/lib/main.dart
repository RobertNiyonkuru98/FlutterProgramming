import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('My first app'),
      centerTitle: true,
      backgroundColor: Colors.red[600],
    ),
    body: Center(
      child: Text('hello ninjas', style:TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        color: Colors.grey[600],
      )),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        print('clicked');
      },
      child: Text('click', style:TextStyle(
        color: Colors.black,
      )),
      backgroundColor:Colors.red[600],
    ),
  ),
));