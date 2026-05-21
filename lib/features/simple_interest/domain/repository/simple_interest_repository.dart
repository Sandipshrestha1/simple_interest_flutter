import 'package:smplintr/features/simple_interest/data/datasource/simpleinterest_remote_datasource.dart';

import '../entities/simple_interest.dart';

abstract class SimpleInterestRepository {
  SimpleInterestRepository(SimpleInterestDatasource simpleInterestDatasource);

  Future<SimpleInterest> calculateInterest({
    required double principal,
    required double rate,
    required double time,
  });
}
