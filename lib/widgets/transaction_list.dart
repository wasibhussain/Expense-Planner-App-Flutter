import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  TransactionList(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height:500 ,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: transaction.length,
        itemBuilder: ((context, index) {
          return Card(
              child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
                child: Text('\$${transaction[index].amount.toStringAsFixed(2)}'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat().format(transaction[index].date),
                      style: const TextStyle(color: Colors.grey))
                ],
              )
            ],
          ));
        }),
      ),
    );
  }
}
