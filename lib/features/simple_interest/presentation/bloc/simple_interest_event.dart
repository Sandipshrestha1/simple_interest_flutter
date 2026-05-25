abstract class SimpleInterestEvent {}

class CalculateInterestEvent extends SimpleInterestEvent {
  final double principal;
  final double rate;
  final double time;
  CalculateInterestEvent({
    required this.principal,
    required this.rate,
    required this.time,
  });
}
