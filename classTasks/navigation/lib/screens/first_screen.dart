import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
    const FirstScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('First Screen'),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        // Navigates to the second screen
                        Navigator.pushNamed(context, '/second');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                    ),
                    child: const Text('Go to Second Screen'),
                ),
            ),
        );
    }
}
