import 'package:flutter/material.dart';
import '../helpers/helprs_ponto.dart';
import 'edit_page.dart';

enum OrderOptions {orderaz, orderza}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});



  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  //instanceando a class banco
  final dbHelper = PontoHelper.instance;

  List<PontoModel> ponto =  List<PontoModel>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getAllPontos();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Pontos",
          style: const TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            color: Colors.blueGrey,
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderaz,
                child:  Text("Ordenar de A-Z",
                  style: const TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderza,
                child:  Text("Ordenar de Z-A",
                  style:  TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: ponto.length,
          itemBuilder: (context, index) {
            //print("PONTO NO LISTVIEW ${ponto[index].ponto}");
            return _pontotCard(context, index);

          }
      ),
    );
  }

  /* METODO PARA GERAR O CARD ONDE APARECERAR O CONTEUDO DA LISTA */
  Widget _pontotCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("CONTRATO: ${ponto[index].contrato}" ?? "",
                      style: TextStyle(fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("SERVIÇO: ${ponto[index].tipo}" ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text("PONTOS: ${ponto[index].ponto.toString()}" ?? "",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
    );
  }

  /* METODO PARA MOSTRA AS OPCAO DE EDITAR E EXCLUIR */
  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: Text("Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          _showPontoPage(ponto: ponto[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: Text("Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: (){
                          dbHelper.deletePonto(ponto[index].id!);
                          setState(() {
                            ponto.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  /* METODO LISTAR TODOS OS DADOS */
  void _showPontoPage({PontoModel? ponto}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => PontoPage(ponto: ponto,))
    );
    if(recContact != null){
      if(ponto != null){
        await dbHelper.updateContact(recContact);
       // print("debugando o metodo UPDATE");
      } else {
        await dbHelper.savePonto(recContact);
        //print("debugando o metodo SAVE");
      }
      _getAllPontos();
    }
  }

  /* METODO LISTAR TODOS OS DADOS */
  void _getAllPontos(){
    dbHelper.getAllPontos().then((list){
      setState(() {
        ponto = list as dynamic;
       // print("debugando a funcao listar todos ${ponto}");
      });
    });
  }

  /* METODO PARA ORDENAR DE A a z */
  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        ponto.sort((a, b) {
          return  a.tipo!.toLowerCase().compareTo(b.tipo!.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        ponto.sort((a, b) {
          return b.tipo!.toLowerCase().compareTo(a.tipo!.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }

}


