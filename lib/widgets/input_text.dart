import 'package:flutter/material.dart';

class InputText extends StatefulWidget {

  final String label;

  InputText({Key key, @required this.label}) : super(key: key);

  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        contentPadding: EdgeInsets.symmetric(vertical: 10)
      ),
    );
  }
}