import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: transaction.length,
        itemBuilder: ((context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text(
                          '\$${transaction[index].amount.toStringAsFixed(2)}')),
                ),
              ),
              title: Text(transaction[index].title),
              subtitle:
                  Text(DateFormat.yMMMMd().format(transaction[index].date)),
                  trailing: IconButton(onPressed: () => deleteTx(transaction[index].id), icon: Icon(Icons.delete, color: Theme.of(context).errorColor,)),
            ),
          );
        }),
      ),
    );
  }
}
