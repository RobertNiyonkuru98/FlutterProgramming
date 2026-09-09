import 'package:flutter/material.dart';

const String myName = 'Robert Tony MITALI Niyonkuru';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          title: const Text('First Project'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.waving_hand, size: 64, color: Colors.teal),
              const SizedBox(height: 16),
              const Text(
                'Hello World',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'My name is $myName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade800,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'AND THIS IS MY FIRST FLUTTER APP',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
