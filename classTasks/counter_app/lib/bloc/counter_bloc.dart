import 'package:flutter_bloc/flutter_bloc.dart';

/// Events that can be dispatched to [CounterBloc]
abstract class CounterEvent {}

/// Event triggered to increment the counter
class CounterIncrementPressed extends CounterEvent {}

/// Event triggered to decrement the counter
class CounterDecrementPressed extends CounterEvent {}

/// Event triggered to reset the counter back to zero
class CounterResetPressed extends CounterEvent {}

/// [CounterBloc] manages an integer state using event-driven architecture.
/// In BLoC, UI sends events -> BLoC processes events -> BLoC emits new states.
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    // Register event handlers
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
    on<CounterResetPressed>((event, emit) => emit(0));
  }
}
