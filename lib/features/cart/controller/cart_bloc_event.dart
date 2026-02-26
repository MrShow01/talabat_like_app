abstract class CounterEvent {}

final class CounterIncrement extends CounterEvent {}

final class CounterDecrement extends CounterEvent {}

final class CounterReset extends CounterEvent {}
