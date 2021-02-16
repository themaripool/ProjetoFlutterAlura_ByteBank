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
        body: ListaTransferencias(),
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

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, index) {
          print("aaaaa");
          print('$widget._transferencias[index]');

          final Transferencia transferencia = widget._transferencias[index];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('chegou no then do future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(() {
                  widget._transferencias.add(transferenciaRecebida);
                });
              }
            });
          });
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    print("entrou card");
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
