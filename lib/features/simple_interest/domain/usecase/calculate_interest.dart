import '../entities/simple_interest.dart';
import '../repository/simple_interest_repository.dart';

class CalculateInterest {
  final SimpleInterestRepository repository;

  CalculateInterest(this.repository);

  Future<SimpleInterest> call({
    required double principal,
    required double rate,
    required double time,
  }) {
    return repository.calculateInterest(
      principal: principal,
      rate: rate,
      time: time,
    );
  }
}
