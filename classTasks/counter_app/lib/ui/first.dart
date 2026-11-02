import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';
import 'second.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen (Cubit)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Current Counter Value:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // BlocBuilder listens to CounterCubit and rebuilds only this widget
              // whenever a new state (count) is emitted.
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.indigo.shade200, width: 2),
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Control buttons to interact with the Cubit
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'decrement_first',
                    onPressed: () {
                      // context.read finds the CounterCubit and calls decrement()
                      context.read<CounterCubit>().decrement();
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: 'reset_first',
                    onPressed: () {
                      context.read<CounterCubit>().reset();
                    },
                    backgroundColor: Colors.grey.shade700,
                    child: const Icon(Icons.refresh, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  FloatingActionButton(
                    heroTag: 'increment_first',
                    onPressed: () {
                      // context.read finds the CounterCubit and calls increment()
                      context.read<CounterCubit>().increment();
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Navigation button to go to Second Screen
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Go to Second Screen',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
