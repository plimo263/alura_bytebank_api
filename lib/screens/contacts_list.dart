import 'package:bytebank/database/contact_dao.dart';
import 'package:bytebank/screens/contacts_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

import '../components/progress.dart';
import '../models/contacts.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: FutureBuilder<List<Contacts>>(
        initialData: const [], // Para os dados iniciais da lista
        future: _dao.findAll(), // Indica o future
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            // Trabalhando com stream (pedacos de partes) pode usa-lo
            case ConnectionState.active:
              break;
            // Depois de finalizado e o todos os dados foram retornados
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Contacts> contacts = snapshot.data;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return _ContactItem(
                      contact: contacts[index],
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionForm(contact: contacts[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              break;
            default:
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContatcsForm(),
                ),
              )
              .then((value) => setState(() => {}));
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contacts contact;
  final Function onClick;

  const _ContactItem({
    Key? key,
    required this.contact,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
