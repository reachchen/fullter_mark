import 'package:flutter/widgets.dart';

class FractionallySizedTransition extends AnimatedWidget {
  final  Widget child;

  FractionallySizedTransition({
    Key? key,
    required Animation<double> factor,
    required this.child,
  }) : super(key: key, listenable: factor);

  @override
  Widget build(BuildContext context) {
    Animation<double>? animation = listenable as Animation<double>?;
    return FractionallySizedBox(
      child: child,
      widthFactor: animation!.value,
      heightFactor: animation.value,
    );
  }
}