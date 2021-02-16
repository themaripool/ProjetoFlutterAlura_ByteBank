import 'package:byteBank/components/Editor.dart';
import 'package:byteBank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controlladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controlladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criando Transferência"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Editor(
                  controlador: _controlladorCampoNumeroConta,
                  labelHint: '0000',
                  labelText: 'Número da conta'),
              Editor(
                  controlador: _controlladorCampoValor,
                  labelHint: '1000',
                  labelText: 'Valor',
                  icone: Icons.monetization_on),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RaisedButton(
                  child: Text("Confirmar"),
                  textColor: Colors.white,
                  onPressed: () {
                    _criaTransferencia(context);
                  },
                ),
              )
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controlladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controlladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);

      // Scaffold.of(context).showSnackBar(
      //   //toast
      //   SnackBar(
      //     content: Text('$transferenciaCriada'),
      //   ),
      // );

      Navigator.pop(context, transferenciaCriada);
    }
  }
}