import 'package:flutter_bloc/flutter_bloc.dart';

/// [CounterCubit] manages an integer state using simpler method-based triggers.
/// Unlike full BLoC (which uses events), Cubit uses functions to directly emit states.
class CounterCubit extends Cubit<int> {
  // Initial state is 0
  CounterCubit() : super(0);

  /// Increment the counter by 1
  void increment() => emit(state + 1);

  /// Decrement the counter by 1
  void decrement() => emit(state - 1);

  /// Reset counter back to 0
  void reset() => emit(0);
}
