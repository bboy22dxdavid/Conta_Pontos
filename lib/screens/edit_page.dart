import 'package:flutter/material.dart';
import '../helpers/helprs_ponto.dart';

class PontoPage extends StatefulWidget {
  const PontoPage({super.key, this.ponto});

  //importando a class model
   final PontoModel? ponto;

  @override
  State<PontoPage> createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {


  //instanceando a class banco
  final dbHelper = PontoHelper.instance;

  //contoller
  final _contratoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _pontoController = TextEditingController();

  final _contratoFocus = FocusNode();

  bool _userEdited = false;

  late PontoModel _editedPonto;

  @override
  void initState() {
    super.initState();
    if(widget.ponto == null){
      _editedPonto = PontoModel();
    } else {
      _editedPonto = PontoModel.fromMap(widget.ponto!.toMap());

      _tipoController.text = _editedPonto.tipo!;
      _contratoController.text = _editedPonto.contrato!;
      _pontoController.text = _editedPonto.ponto!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text(_editedPonto.tipo ?? "Novo Contrato",
              style: const TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(_editedPonto.tipo != null && _editedPonto.tipo!.isNotEmpty){
                Navigator.pop(context, _editedPonto);
                print("debugando o botao flutuante${_editedPonto}");
              } else {
                FocusScope.of(context).requestFocus(_contratoFocus);
              }
            },
            child: Icon(Icons.save, color: Colors.white,),
            backgroundColor: Colors.blueGrey,
          ),
          body:  SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _contratoController,
                  focusNode: _contratoFocus,
                  decoration: const InputDecoration(
                    labelText: "Contrato WO",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      )
                  ),
                  onChanged: (text){
                    _userEdited = true;
                    setState(() {
                      _editedPonto.contrato = text;
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16,),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(
                      labelText: "Tipo De Serviço",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      )
                  ),
                  onChanged: (text){
                    _userEdited = true;
                    _editedPonto.tipo = text;
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16,),
                TextField(
                  controller: _pontoController,
                  decoration:const InputDecoration(
                      labelText: "Valor Em Pontos",
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    )
                  ),
                  onChanged: (text){
                    _userEdited = true;
                    _editedPonto.ponto = text;
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        )
    );
  }

  Future<bool> _requestPop(){
    if(_userEdited){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: Size.fromWidth(100),
                    padding: EdgeInsets.all(10),
                  ),
                  child: Text("Cancelar"),
                  onPressed: () {
                    //Code Here
                    Navigator.pop(context);
                  },
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: Size.fromWidth(100),
                    padding: EdgeInsets.all(10),
                  ),
                  child: Text("Sim"),
                  onPressed: () {
                    //Code Here
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}


