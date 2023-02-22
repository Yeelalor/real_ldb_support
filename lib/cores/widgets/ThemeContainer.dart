import 'package:flutter/material.dart';

// import '../../style/dimensions.dart';

class ThemeContainer extends StatelessWidget {
  const ThemeContainer({
    required this.child,
    this.up = false,
    this.color = Colors.white,
    this.radius = 12,
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  final Widget child;
  final bool up;
  final Color color;
  final Color backgroundColor;
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          minWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: child,
    );
  }
}
