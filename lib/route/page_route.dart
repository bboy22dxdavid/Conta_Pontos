import 'package:conta_pontos/screens/calc_page.dart';
import 'package:conta_pontos/screens/list_screen.dart';
import 'package:conta_pontos/screens/edit_page.dart';
import 'package:conta_pontos/screens/save_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class RoutePages extends StatefulWidget {
  const RoutePages({super.key});

  @override
  State<RoutePages> createState() => _RoutePagesState();
}

class _RoutePagesState extends State<RoutePages> {

//variavel contador
  int pageIndex = 0;

  final CalcPage _calcPage = CalcPage();
  final SavePage _savePage = SavePage();
  // final PontoPage _savePage = PontoPage();

  final ListScreen _homeScreen = ListScreen();


  Widget _showPage = new ListScreen();

  Widget _pageChooser(int page){
    switch (page){
      case 0:
        return _homeScreen;
      case 1:
        return _calcPage;
      case 2:
        return _savePage;
      default:
        return  Container(
        child: const Text("nenhuma pagina selecionada", style:  TextStyle(
          color: Colors.black, fontSize: 30),),
        );

    }
  }

  //variavel chave
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: pageIndex,
        items: [
          Icon(Icons.receipt_long_rounded, size: 30, color: Colors.white,),
          Icon(Icons.list, size: 30, color: Colors.white,),
          Icon(Icons.add, size: 30, color: Colors.white,),
        ],
        color: Colors.blueGrey,
        buttonBackgroundColor: Colors.blueGrey,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex){
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}
