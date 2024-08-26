import 'package:conta_pontos/helpers/helprs_ponto.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key, this.ponto});

  //importando a class model
  final PontoModel? ponto;

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {

  //instanceando a class banco
  final dbHelper = PontoHelper.instance;

  //contoller
  final _contratoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _pontoController = TextEditingController();

  final PontoModel _ponto = PontoModel();

  void _salvarDados(){
   /*print("Contrato ${_contratoController.text}");
   print("Tipo ${_tipoController.text}");
   print("Ponto ${_pontoController.text}");*/
     _ponto.contrato = _contratoController.text;
     _ponto.tipo = _tipoController.text;
     _ponto.ponto = _pontoController.text;

     dbHelper.savePonto(_ponto);

     _dialogo();
  }

  @override
  void initState() {
    super.initState();
   /* //TESTANDO BANCO DE DADOS

    ponto.tipo = '1305222';
    ponto.contrato = 'imagem';
    ponto.ponto = '9999';
   dbHelper.savePonto(ponto);

    dbHelper.getNumber().then((list){
      print('MEUS DADOS SALVOS: ${list}');
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title:const Text("Novo Contrato",
          style:  TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),

      body:SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _contratoController,
              decoration: const InputDecoration(
                  labelText: "Contrato WO",
                  border:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                       Radius.circular(10.0),
                    ),
                  )
              ),
              onChanged: (text){
                //*print("Valor do TexteField ${_contratoController.text = text}");*//*
                _contratoController.text = text;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _tipoController,
              decoration: const InputDecoration(
                  labelText: "Tipo De Serviço",
                  border:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                       Radius.circular(10.0),
                    ),
                  )
              ),
              onChanged: (text){
                //*print("Valor do TexteField ${_tipoController.text = text}");*//*
                _tipoController.text = text;
              },
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _pontoController,
              decoration:const InputDecoration(
                  labelText: "Valor Em Pontos",
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                       Radius.circular(10.0),
                    ),
                  )
              ),
              onChanged: (text){
                //*print("Valor do TexteField ${_pontoController.text = text}");*//*
                _pontoController.text = text;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: (){
                _salvarDados();
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(500, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueGrey
              ),
              child: const Text("SALVAR",
                style: TextStyle(color: Colors.white, fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Future _dialogo(){
    return showDialog(
        context: context,
        builder: (_) => Center( // Aligns the container to center
            child:  Container(
              width: 350,
              height: 200,
              color: Colors.blueGrey,
              child: const Center(
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Text("Contrato Salvo Com Sucesso!",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            )
        )
    );
  }

}
