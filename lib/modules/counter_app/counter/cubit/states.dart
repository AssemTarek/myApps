abstract class CounterStates {}

class CounterMinusState extends CounterStates {
  final int counter;

  CounterMinusState(this.counter);
}

class CounterInitialState extends CounterStates {
}

class CounterPlusState extends CounterStates {
  final int counter;

  CounterPlusState(this.counter);
}
