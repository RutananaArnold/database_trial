import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color fcolor;
  const TextFieldContainer({
    Key key,
    this.child,
    this.fcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: fcolor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
