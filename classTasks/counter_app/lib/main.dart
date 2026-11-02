import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Importing state management and UI modules from their respective folders
import 'bloc/counter_bloc.dart';
import 'cubit/counter_cubit.dart';
import 'ui/first.dart';
import 'ui/second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider injects both CounterCubit and CounterBloc at the root
    // of the widget tree so all child screens (FirstScreen, SecondScreen) can
    // access and share the same state across routes!
    return MultiBlocProvider(
      providers: [
        // Provides the Cubit instance
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        // Provides the full Bloc instance
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cubit Counter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const FirstScreen(),
        routes: {
          '/first': (context) => const FirstScreen(),
          '/second': (context) => const SecondScreen(),
        },
      ),
    );
  }
}
