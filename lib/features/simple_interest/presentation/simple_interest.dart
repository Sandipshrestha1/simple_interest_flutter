import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smplintr/core/constants/network/internet_checker.dart';
import 'package:smplintr/core/utils/widget/loader.dart';
import 'package:smplintr/features/simple_interest/domain/entities/simple_interest.dart';
import 'package:smplintr/features/simple_interest/presentation/bloc/simple_interest_bloc.dart';
import 'package:smplintr/features/simple_interest/presentation/bloc/simple_interest_event.dart';
import 'package:smplintr/features/simple_interest/presentation/bloc/simple_interest_state.dart';
import 'package:smplintr/features/simple_interest/presentation/widget/shimmer_effect.dart';

class SimpleInterestScreen extends StatefulWidget {
  const SimpleInterestScreen({super.key});

  @override
  State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
  final principalController = TextEditingController();
  final rateController = TextEditingController();
  final timeController = TextEditingController();

  final InternetChecker internetChecker = InternetChecker();

  void calculateInterest() {
    final principal = double.tryParse(principalController.text) ?? 0;

    final rate = double.tryParse(rateController.text) ?? 0;

    final time = double.tryParse(timeController.text) ?? 0;

    context.read<SimpleInterestBloc>().add(
      CalculateInterestEvent(principal: principal, rate: rate, time: time),
    );
  }

  @override
  void dispose() {
    principalController.dispose();
    rateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Interest")),

      body: BlocBuilder<SimpleInterestBloc, SimpleInterestState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Principal",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Rate",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Time",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state is NoInternetState
                          ? Colors.red
                          : null,
                    ),
                    onPressed: state is SimpleInterestLoading
                        ? null
                        : calculateInterest,
                    child: state is SimpleInterestLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: ColorChangingLoader(strokeWidth: 2.5),
                          )
                        : Text(
                            state is NoInternetState
                                ? "No Internet"
                                : "Calculate",
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ SHOW SHIMMER OR RESULT
                if (state is SimpleInterestLoading)
                  buildShimmerCard(context)
                else if (state is SimpleInterestLoaded)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Principal: ${state.result.principal }"),
                          Text("Rate: ${state.result.rate}"),
                          Text("Time: ${state.result.time}"),
                          const Divider(),
                          Text(
                            "Interest: ${state.result.interest}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total Amount: ${state.result.totalAmount}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
