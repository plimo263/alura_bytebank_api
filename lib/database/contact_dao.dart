import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableName = 'contacts';
  static const String id = 'id';
  static const String name = 'name';
  static const String accountNumber = 'account_number';

  static const String tablesql = 'CREATE TABLE $tableName ('
      '$id INTEGER PRIMARY KEY, '
      '$name TEXT, '
      '$accountNumber INTEGER'
      ')';

  Future<int> save(Contacts contact) async {
    // Obter a referencia ao banco de dados
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(ContactDao.tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contacts contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return contactMap;
  }

//
  Future<List<Contacts>> findAll() async {
    // Obter a referencia ao banco de dados
    final Database db = await getDatabase();
    //
    final List<Map<String, dynamic>> rows =
        await db.query(ContactDao.tableName);
    return _toList(rows);
  }

  List<Contacts> _toList(List<Map<String, dynamic>> rows) {
    // Criando uma lista de contacts
    List<Contacts> contacts = [];
    for (var row in rows) {
      final Contacts contact = Contacts(
        row['id'],
        row['name'],
        row['account_number'],
      );
      contacts.add(contact);
    }

    return contacts;
  }
}
