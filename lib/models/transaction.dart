import 'contacts.dart';

class Transaction {
  final String id;
  final double value;
  final Contacts contact;

  Transaction(
    this.id,
    this.value,
    this.contact,
  );

  Transaction.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        id = json['id'],
        contact = Contacts.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
