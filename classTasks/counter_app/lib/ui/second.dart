import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen (Shared State)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Card(
                color: Color(0xFFE0F2F1),
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.teal),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This screen shares the same CounterCubit! Changes made here persist when you return to the first screen.',
                          style: TextStyle(color: Colors.black87, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Shared Counter Value:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // Rebuilding with the exact same shared Cubit instance
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.teal.shade200, width: 2),
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Buttons on second screen to mutate the shared state
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'decrement_second',
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  const SizedBox(width: 24),
                  FloatingActionButton(
                    heroTag: 'increment_second',
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Back button to return to FirstScreen
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  side: const BorderSide(color: Colors.teal, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  'Back to First Screen',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
