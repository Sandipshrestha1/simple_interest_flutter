import 'package:smplintr/features/simple_interest/data/datasource/simpleinterest_remote_datasource.dart';
import 'package:smplintr/features/simple_interest/data/model/simple_interest_model.dart';

import '../../domain/entities/simple_interest.dart';
import '../../domain/repository/simple_interest_repository.dart';

class SimpleInterestRepositoryImpl implements SimpleInterestRepository {
  final SimpleInterestDatasource datasource;

  SimpleInterestRepositoryImpl(this.datasource);

  @override
  Future<SimpleInterest> calculateInterest({
    required double principal,
    required double rate,
    required double time,
  }) async {
    final response = await datasource.calculateInterest({
      "principal": principal,
      "rate": rate,
      "time": time,
    });

    final model = SimpleInterestResponseModel.fromJson(response);

    return SimpleInterest(
      principal: model.principal,
      interest: model.interest,
      totalAmount: model.totalAmount,
      rate: rate,
      time: time,
    );
  }
}
