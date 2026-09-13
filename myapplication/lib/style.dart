import 'dart:math'; // 1. IMPORT: You must import dart:math to use the Random() class
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // 2. SCOPE: A helper function cannot be declared inside a 'return' statement. 
    // It must live inside the class body, outside of the build method!
    List<Widget> _randomColors() {
        Random rnd = Random();
        return List.generate(25, (int i) => Container(
            color: Color.fromRGBO(
                rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255), 1.0
            ),
        ));
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Styling'),
                    centerTitle: true,
                    backgroundColor: Colors.blue[600],
                ),
                // 3. WIDGET STRUCTURE: The 'body' expects a Widget. You passed 'child' and 'decoration'
                // floating in space. They must be wrapped inside a Container Widget!
                body: Container(
                    decoration: BoxDecoration(
                      color: Colors.red, 
                      border: Border.all(color: Colors.yellow, width: 5)
                    ),
                    // 4. USAGE: Your original code never actually displayed the random colors.
                    // I put them in a Column so you can see both your text and your colors!
                    child: Column(
                      children: [
                        const Text('Colors!', style: TextStyle(color: Colors.white, fontSize: 30)),
                        
                        // Expanded lets the colored boxes fill the remaining screen space
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 5, // 5 columns
                            children: _randomColors(), // Call your random color function here!
                          ),
                        )
                      ],
                    ),
                ),
            )
        ); // 5. SYNTAX: Semicolon needed here to finish the return statement!
    }
}