
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String labelText;
  final String labelHint;
  final IconData icone;

  const Editor(
      {Key key, this.controlador, this.labelText, this.labelHint, this.icone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      style: TextStyle(fontSize: 24.0),
      decoration: InputDecoration(
        icon: icone != null ? Icon(icone) : null,
        labelText: labelText,
        hintText: labelHint,
      ),
      keyboardType: TextInputType.number,
    );
  }
}