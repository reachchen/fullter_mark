import 'package:flutter/material.dart';

class LabelGroup extends StatelessWidget{

  final String labelText;
  final TextStyle? labelStyle;
  final Widget child;
  final EdgeInsetsGeometry? padding;


  LabelGroup({
    Key? key,
    required this.labelText,
    this.labelStyle,
    required this.child,
    this.padding,
  }) : assert(labelText !=null),assert(child !=null),super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: labelStyle,
          ),
          this.child,
        ],
      ),
    );
  }

}