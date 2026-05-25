import 'package:smplintr/main.dart';

abstract class SimpleInterestState {}

class SimpleInterestInitial extends SimpleInterestState {}

class SimpleInterestLoading extends SimpleInterestState {}

class SimpleInterestLoaded extends SimpleInterestState {
  final SimpleInterest result;
  SimpleInterestLoaded(this.result);
}

class SimpleInterestError extends SimpleInterestState {
  final String message;
  SimpleInterestError(this.message);
}

class NoInternetState extends SimpleInterestState {}
