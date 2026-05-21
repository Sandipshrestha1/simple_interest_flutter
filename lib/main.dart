import "package:flutter/material.dart";
import "package:smplintr/core/theme/app_theme.dart";
import "package:smplintr/features/simple_interest/presentation/simple_interest.dart";

void main() {
  runApp(const SimpleInterest());
}

class SimpleInterest extends StatelessWidget {
  const SimpleInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SimpleInterestPage(),
    );
  }
}
