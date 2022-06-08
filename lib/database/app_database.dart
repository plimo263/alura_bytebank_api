// Funcao para criar o banco de dados
import 'package:bytebank/database/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  // Acesso ao path para armazer o banco de dados
  final String dbPath = await getDatabasesPath();
  // Acesso ao banco de dados unindo o path ao nome
  final String path = join(dbPath, 'bytebank.db');
  // Criando a tabela pela primeira vez (algo que não será executado na segunda)
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.tablesql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
