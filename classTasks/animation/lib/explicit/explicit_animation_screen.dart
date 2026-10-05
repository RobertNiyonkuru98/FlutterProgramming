import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() => _ExplicitAnimationScreenState();
}

// We need TickerProviderStateMixin to sync the animation with the screen's refresh rate (vsync)
class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // The controller dictates HOW LONG the animation takes
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // The Tween dictates WHAT VALUES the animation moves between (0.0 to 1.0 turn = 360 degrees)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Always dispose controllers to prevent memory leaks!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explicit Animation")),
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: const Icon(Icons.refresh, size: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // .forward(from: 0.0) ensures it starts from the beginning every time you click it!
          _controller.forward(from: 0.0);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
