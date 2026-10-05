import 'package:flutter/material.dart';

// 1. We import the other files so this file knows what FirstScreen and SecondScreen are!
import 'screens/first_screen.dart';
import 'screens/second_screen.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
    },
));