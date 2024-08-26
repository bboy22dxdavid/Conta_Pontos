import 'package:conta_pontos/helpers/helprs_ponto.dart';
import 'package:flutter/material.dart';



class CalcPage extends StatefulWidget {
  const CalcPage({super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {

  //instanceando a class banco
  final dbHelper = PontoHelper.instance;
   var ponto;
  String meta = "1372";
  var totalContrato;

  //late double doubleCalc = double.parse(calculo!);
  /*late double doubleMeta = double.parse(meta);
  late double result = doubleCalc - doubleMeta;*/


  @override
  void initState() {
    super.initState();
    _somaAllPontos();
    _contratos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Resultado final",
          style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 250,
          padding: const EdgeInsets.only(top: 30),
          child: Card(
            margin: const EdgeInsets.all(12.0),
            shadowColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                       Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('TOTAL META: ${meta.toString()}',
                          style: const TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.bold, color: Colors.red ),
                        ),
                        const SizedBox(height: 16,),
                        Text('TOTAL PONTOS: ${ponto.toString()} ',
                          style: const TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 16,),
                        Text('Total Contratos: ${totalContrato} ',
                          style: const TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* METODO SOMAR TODOS OS DADOS */
  void _somaAllPontos(){
    dbHelper.soma().then((list){
      setState(() {
        ponto = list as dynamic;
        // print("debugando a funcao somar todos ${total}");
         return ponto;
      });
    });
  }

  /* METODO SOMAR TODOS OS DADOS */
 void _contratos(){
    dbHelper.getNumber().then((list){
      setState(() {
        totalContrato = list as dynamic;
        // print("debugando a funcao somar todos ${total}");
        return totalContrato;
      });
    });
  }

}
