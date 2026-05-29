import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:smplintr/core/theme/app_theme.dart";
import "package:smplintr/features/simple_interest/presentation/bloc/simple_interest_bloc.dart";
import "package:smplintr/features/simple_interest/presentation/simple_interest.dart";

void main() {
  runApp(const SimpleInterestApp());
}

class SimpleInterestApp extends StatelessWidget {
  const SimpleInterestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => SimpleInterestBloc(),
        child: SimpleInterestScreen(),
      ),
    );
  }
}
