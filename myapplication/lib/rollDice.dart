import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  // 1. We keep track of the current dice number (1 through 6)
  int currentDiceValue = 2; // Defaulting to 2 as shown in your picture
  
  // Create a random number generator
  final Random random = Random();

  // 2. This function runs when the button is pressed
  void rollDice() {
    setState(() {
      // nextInt(6) gives 0-5, so we add 1 to get 1-6
      currentDiceValue = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. Set the background color of the whole screen
      backgroundColor: Colors.deepPurple[800], 
      body: Center(
        // 4. Use a Column to stack the text, image, and button vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Let's play",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40), // Spacer
            
            // 5. This displays the image from your assets folder!
            // Notice how we inject the variable into the string path
            Image.asset(
              'assets/dice-$currentDiceValue.png',
              width: 200,
            ),
            
            const SizedBox(height: 60), // Spacer
            
            // 6. The Roll Dice button
            ElevatedButton(
              onPressed: rollDice,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[400], // Match the button color from your image
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              child: const Text(
                'Roll Dice',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}