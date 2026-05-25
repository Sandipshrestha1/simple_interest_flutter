import 'package:flutter/material.dart';
import 'package:smplintr/core/constants/network/internet_checker.dart';
import 'package:smplintr/core/utils/widget/loader.dart';
import 'package:smplintr/features/simple_interest/domain/entities/simple_interest.dart';
import 'package:smplintr/features/simple_interest/presentation/simple_interest_controller.dart';
import 'package:smplintr/features/simple_interest/presentation/widget/shimmer_effect.dart';

class SimpleInterestPage extends StatefulWidget {
  const SimpleInterestPage({super.key});

  @override
  State<SimpleInterestPage> createState() => _SimpleInterestPageState();
}

class _SimpleInterestPageState extends State<SimpleInterestPage> {
  final principalController = TextEditingController();
  final rateController = TextEditingController();
  final timeController = TextEditingController();

  final InternetChecker internetChecker = InternetChecker();
  SimpleInterest? result;

  bool isLoading = false;
  bool noInternet = false;
  late SimpleInterestController controller;

  @override
  void initState() {
    super.initState();
    controller = SimpleInterestController();
  }

  void calculateInterest() async {
    final hasInternet = await internetChecker.hasInternet();

    if (!mounted) return;
    if (!hasInternet) {
      setState(() {
        noInternet = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: ActionChip(label: Text("No internet Connection")),
        ),
      );
      return;
    }
    setState(() {
      noInternet = false;
      isLoading = true;
    });

    final principal = double.tryParse(principalController.text) ?? 0;

    final rate = double.tryParse(rateController.text) ?? 0;

    final time = double.tryParse(timeController.text) ?? 0;

    final response = await controller.calculate(
      principal: principal,
      rate: rate,
      time: time,
    );

    setState(() {
      result = response;
      isLoading = false;
    });
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

      body: Padding(
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
                  backgroundColor: noInternet ? Colors.red : null,
                ),
                onPressed: isLoading ? null : calculateInterest,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: ColorChangingLoader(strokeWidth: 2.5),
                      )
                    : Text(noInternet ? "No Internet" : "Calculate"),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ SHOW SHIMMER OR RESULT
            if (isLoading)
              buildShimmerCard(context)
            else if (result != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Principal: ${result?.principal ?? 0}"),
                      Text("Rate: ${result!.rate}"),
                      Text("Time: ${result!.time}"),
                      const Divider(),
                      Text(
                        "Interest: ${result!.interest}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Total Amount: ${result!.totalAmount}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
