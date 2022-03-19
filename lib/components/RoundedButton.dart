import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double screen;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.purple,
    this.textColor = Colors.white,
    this.screen = 0.9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * screen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}


class RoundeButton extends StatelessWidget {
  const RoundeButton({
    Key key,
    this.size,
    this.press,
    this.screen = 0.9,
    this.text,
    this.color = Colors.purple,
  }) : super(key: key);

  final Size size;
  final double screen;
  final Function press;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * screen,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: FlatButton(
              color: color,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              onPressed: press,
              child: Text(text))),
    );
  }
}
