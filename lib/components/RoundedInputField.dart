import 'package:flutter/material.dart';
import 'package:database_trial/components/TextFieldContainer.dart';
import 'package:database_trial/components/palette.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> validate;
  final TextEditingController field;
  final Color fcolor;
  final TextInputType keyboard;
  final Function tap;
  final bool x;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person_outline,
    this.onChanged,
    this.validate,
    this.field,
    this.fcolor = Colors.black12,
    this.keyboard = TextInputType.text,
    this.tap,
    this.x = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      fcolor: fcolor,
      child: TextFormField(
        onChanged: onChanged,
        onTap: tap,
        readOnly: x,
        cursorColor: kappPrimary,
        keyboardType: keyboard,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kappPrimary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: kappPrimary,
          ),
          border: InputBorder.none,
        ),
        validator: validate,
        controller: field,
      ),
    );
  }
}
