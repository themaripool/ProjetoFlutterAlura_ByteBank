import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Transferências"),),
      body: ListaTransferencias(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),),
    ),
  ));
}

//StatefulWidget -> Consegue mudar o conteudo do widget de forma dinamica
//StatelessWidget -> Nao consegue mudar o conteudo dinamicamente

class ListaTransferencias extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            ItemTransferencia(Transferencia(200.0, 1000)),
            ItemTransferencia(Transferencia(300.0, 1000)),
            ItemTransferencia(Transferencia(400.0, 1000))
        ],
      );
  }
}

class ItemTransferencia extends StatelessWidget{

  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(_transferencia.valor.toString()),
              subtitle: Text(_transferencia.numeroConta.toString()),
              )
            );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta);
}