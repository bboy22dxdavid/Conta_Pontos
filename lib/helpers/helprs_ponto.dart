import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String pontoTable = "pontoTable";
const String idColumn = "idColumn";
const String tipoColumn = "tipoColumn";
const String contratoColumn = "contratoColumn";
const String pontoColumn = "phoneColumn";


class PontoHelper {

  PontoHelper._();

  static final PontoHelper instance = PontoHelper._internal();
  //instaciando o banco
  Database? _db;

  PontoHelper._internal();


  Future<Database> get db async {
    if(_db != null){
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "pontos_meta.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $pontoTable($idColumn INTEGER PRIMARY KEY, $tipoColumn TEXT, $contratoColumn TEXT,"
              "$pontoColumn TEXT)"
      );
    });
  }
  /*==========================================
              INICIANDO O CRUD
  *==========================================
   */


  /*==========================================
              FUNCTION PARA SALVAR
  *==========================================
   */
  Future<PontoModel> savePonto(PontoModel ponto) async {
    Database dbPonto = await db;
    ponto.id = await dbPonto.insert(pontoTable, ponto.toMap());
    return ponto;
  }

  Future<PontoModel> getPonto(int id) async {
    Database dbPonto = await db;
    List<Map> maps = await dbPonto.query(pontoTable,
        columns: [idColumn, tipoColumn, contratoColumn, pontoColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.isNotEmpty){
      return PontoModel.fromMap(maps.first);
    } else {
      return null!;
    }
  }

  Future<int> deletePonto(int id) async {
    Database dbPonto = await db;
    return await dbPonto.delete(pontoTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(PontoModel ponto) async {
    Database dbPonto = await db;
    return await dbPonto.update(pontoTable,
        ponto.toMap(),
        where: "$idColumn = ?",
        whereArgs: [ponto.id]);
  }

  Future<List> getAllPontos() async {
    Database dbPonto = await db;
    List listMap = await dbPonto.rawQuery("SELECT * FROM $pontoTable");
    List<PontoModel> listPonto = List<PontoModel>.empty(growable: true);
    for(Map m in listMap){
      listPonto.add(PontoModel.fromMap(m));
    }
    return listPonto;
  }

  Future<int?> getNumber() async {
    Database dbPonto = await db;
    return Sqflite.firstIntValue(await dbPonto.rawQuery("SELECT COUNT(*) FROM $pontoTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

  Future<Object?> soma() async {
    Database dbPonto = await db;
    var result = await dbPonto.rawQuery('SELECT SUM($pontoColumn) FROM $pontoTable');
   // print(result[0]["SUM($pontoColumn)"]);
    return result[0]["SUM($pontoColumn)"];
  }

}

class PontoModel {

  int? id;
  String? tipo;
  String? contrato;
  String? ponto;


  PontoModel({this.id, this.tipo, this.contrato, this.ponto});

  PontoModel.fromMap(Map map){
    id = map[idColumn];
    tipo = map[tipoColumn];
    contrato = map[contratoColumn];
    ponto = map[pontoColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, dynamic> map = {
      tipoColumn: tipo,
      contratoColumn: contrato,
      pontoColumn: ponto
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "PontoModel(id: $id, tipo: $tipo, contrato: $contrato, ponto: $ponto)";
  }

}