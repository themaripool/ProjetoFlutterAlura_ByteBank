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
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

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
                  color: Colors.blue,
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
    final int numeroConta =
        int.tryParse(_controlladorCampoNumeroConta.text);
    final double valor =
        double.tryParse(_controlladorCampoValor.text);
    
    if (numeroConta != null && valor != null) {
      final transferenciaCriada =
          Transferencia(valor, numeroConta);
    
      Scaffold.of(context).showSnackBar(
        //toast
        SnackBar(
          content: Text('$transferenciaCriada'),
        ),
      );
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String labelText;
  final String labelHint;
  final IconData icone;

  const Editor({Key key, this.controlador, this.labelText, this.labelHint, this.icone})
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

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(200.0, 1000)),
          ItemTransferencia(Transferencia(300.0, 1000)),
          ItemTransferencia(Transferencia(400.0, 1000))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia {valor: $valor, numeroConta: $numeroConta}';
  }
}
