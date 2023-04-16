/*import 'package:flutter/material.dart';
import './NewTransaction.dart';
import './TransactionList.dart';
import '../models/transaction.dart';
class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}
class _UserTransactionState extends State<UserTransaction> {
  @override
  List<Transaction> _userTransactions=[
    Transaction(id: '34', title: 'New shoe', amount: 23.4, date: DateTime.now()),
    Transaction(id: '25', title: 'Grocery Items', amount: 24, date: DateTime.now())
  ];

  void _addNewTransaction( String title, double amount){
    final newTx = Transaction(
        id:DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  Widget build(BuildContext context) {
    return  Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}*/
