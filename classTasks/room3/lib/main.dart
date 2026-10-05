import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: TweenAnimationScreen(),
));

class TweenAnimationScreen extends StatefulWidget {
  const TweenAnimationScreen({super.key});

  @override
  State<TweenAnimationScreen> createState() => _TweenAnimationScreenState();
}

class _TweenAnimationScreenState extends State<TweenAnimationScreen> {
  double _progress = 0.0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('room3'),
        centerTitle: true,
        backgroundColor:Colors.tealAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin:0, end: _progress),
            duration: Duration(seconds: 1),
            builder:(context, value, child){
              return SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor:Colors.tealAccent,
                ),
              );
            },
          ),
          const SizedBox(height: 50),

          Slider(
            value: _progress,
            onChanged:(value){
              setState(() {
                _progress = value;
              });
            },
          ),
          Text('Upload Progress: ${(_progress * 100).toInt()}%', 
          style: TextStyle(fontSize: 18)
          ),
        ],
      ),
    );
  }
}

