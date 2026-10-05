import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
    const SecondScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Second Screen'),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            color: Colors.grey[300],
                            child: const Text('go to the first screen', style: TextStyle(color: Colors.black87)),
                        ),
                        const SizedBox(height: 10),
                        
                        ElevatedButton(
                            onPressed: () {
                                // Pops back to the first screen
                                Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                            ),
                            child: const Text('Go Back'),
                        ),
                    ],
                ),
            ),
        );
    }
}
