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

  final TextEditingController _controlladorCampoNumeroConta = TextEditingController();
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
              TextField(
                controller: _controlladorCampoNumeroConta,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  labelText: 'Número da conta',
                  hintText: '0000',
                ),
                keyboardType: TextInputType.number,
              ),

              TextField(
                controller: _controlladorCampoValor,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Valor',
                  hintText: '0000',
                ),
                keyboardType: TextInputType.number,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RaisedButton(
                  child: Text("Confirmar"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    debugPrint('clicou no confirmar');
                    final int numeroConta = int.tryParse(_controlladorCampoNumeroConta.text);
                    final double valor = double.tryParse(_controlladorCampoValor.text);

                    if (numeroConta != null && valor != null){
                      final transferenciaCriada = Transferencia(valor, numeroConta);

                      debugPrint(transferenciaCriada.toString());
                    }
                  },
                ),
              )

            ],
          ),
        ));
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
  String toString(){
    return 'Transferencia {valor: $valor, numeroConta: $numeroConta}';
  }
}
