import 'package:flutter/material.dart';

class ColorChangingLoader extends StatefulWidget {
  final double strokeWidth;
  final double size;

  const ColorChangingLoader({
    super.key,
    this.strokeWidth = 2.5,
    this.size = 20,
  });

  @override
  State<ColorChangingLoader> createState() => _ColorChangingLoaderState();
}

class _ColorChangingLoaderState extends State<ColorChangingLoader> {
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
  ];

  int colorIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return false;

      setState(() {
        colorIndex = (colorIndex + 1) % colors.length;
      });

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        valueColor: AlwaysStoppedAnimation(colors[colorIndex]),
      ),
    );
  }
}
