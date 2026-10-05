import 'package:flutter/material.dart';
import 'implicit/implicit_animation_screen.dart';
import 'explicit/explicit_animation_screen.dart';
import 'tween/tween_animation_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animations Tasks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AnimationHome(),
    );
  }
}

// A simple home screen that provides buttons to navigate to the 3 activities!
class AnimationHome extends StatelessWidget {
  const AnimationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animations Menu')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Activity 1: Implicit Animation'),
            subtitle: const Text('AnimatedContainer'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ImplicitAnimationScreen())),
          ),
          const Divider(),
          ListTile(
            title: const Text('Activity 2: Explicit Animation'),
            subtitle: const Text('AnimationController & TickerProvider'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExplicitAnimationScreen())),
          ),
          const Divider(),
          ListTile(
            title: const Text('Activity 3: Tween Animation Builder'),
            subtitle: const Text('Custom Progress Indicator'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TweenAnimationScreen())),
          ),
        ],
      ),
    );
  }
}
