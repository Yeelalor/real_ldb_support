import 'package:flutter/material.dart';

class WrapTheme extends StatelessWidget {
  const WrapTheme({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: RadialGradient(
        colors: [
          Color(0xFF3C98CE),
          Color(0xFF2171A1),
          Color(0xFF144D70),
        ],
        center: Alignment.topLeft,
        radius: 1.2,
      )),
      child: child,
    );
  }
}
