import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smplintr/core/constants/network/internet_checker.dart';
import 'package:smplintr/core/services/base_service.dart';

import 'package:smplintr/features/simple_interest/data/datasource/simpleinterest_remote_datasource.dart';
import 'package:smplintr/features/simple_interest/data/repositories/simple_interest_repository_impl.dart';

import 'package:smplintr/features/simple_interest/presentation/bloc/simple_interest_event.dart';
import 'package:smplintr/features/simple_interest/presentation/bloc/simple_interest_state.dart';

class SimpleInterestBloc
    extends Bloc<SimpleInterestEvent, SimpleInterestState> {
  final internetChecker = InternetChecker();

  SimpleInterestBloc() : super(SimpleInterestInitial()) {
    on<CalculateInterestEvent>((event, emit) async {
      final hasInternet = await internetChecker.hasInternet();

      if (!hasInternet) {
        emit(NoInternetState());
        return;
      }

      emit(SimpleInterestLoading());

      try {
        final repository = SimpleInterestRepositoryImpl(
          SimpleInterestDatasource(BaseService()),
        );

        final response = await repository.calculateInterest(
          principal: event.principal,
          rate: event.rate,
          time: event.time,
        );

        emit(SimpleInterestLoaded(response));
      } catch (e) {
        emit(SimpleInterestError(e.toString()));
      }
    });
  }
}
