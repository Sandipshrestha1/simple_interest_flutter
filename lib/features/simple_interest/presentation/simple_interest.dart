import 'package:flutter/material.dart';
import 'package:smplintr/core/constants/network/internet_checker.dart';
import 'package:smplintr/features/simple_interest/domain/entities/simple_interest.dart';
import 'package:smplintr/features/simple_interest/presentation/simple_interest_controller.dart';

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No internet Connection")));
    }

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
                onPressed: calculateInterest,
                child: const Text("Calculate"),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ FIXED DISPLAY SECTION
            if (result == null)
              const Text("No result yet")
            else
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Principal: ${result!.principal}"),
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
