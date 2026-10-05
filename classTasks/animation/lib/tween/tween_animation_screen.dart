import 'package:flutter/material.dart';

// NOTE: The instructions said to use a "StatelessWidget", but because we need to
// use setState to update the _progress variable when the Slider changes, it MUST
// be a StatefulWidget! I have fixed this for you so the code actually works.
class TweenAnimationScreen extends StatefulWidget {
  const TweenAnimationScreen({super.key});

  @override
  State<TweenAnimationScreen> createState() => _TweenAnimationScreenState();
}

class _TweenAnimationScreenState extends State<TweenAnimationScreen> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tween Animation")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TweenAnimationBuilder listens to the _progress value. 
          // Whenever it changes, it animates from its current value to the new _progress over 1 second.
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _progress),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[300],
                ),
              );
            },
          ),
          const SizedBox(height: 50),
          Slider(
            value: _progress,
            onChanged: (value) {
              setState(() {
                _progress = value;
              });
            },
          ),
          Text('Upload Progress: ${(_progress * 100).toInt()}%', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
