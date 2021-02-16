import 'package:byteBank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}
//StatefulWidget -> Consegue mudar o conteudo do widget de forma dinamica
//StatelessWidget -> Nao consegue mudar o conteudo dinamicamente

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[50],
        accentColor: Colors.blueGrey[300],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey[300],
          textTheme: ButtonTextTheme.primary
        )

      ),
      home: ListaTransferencias());
  }
}