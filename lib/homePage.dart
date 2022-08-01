import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';
import 'widgets/new_transactoin.dart';
import 'widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 bool showChart = false;
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: '1', title: 'T-Shirts', amount: 255.5, date: DateTime.now()),
    // Transaction(id: '2', title: 'Shoes', amount: 555.5, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    })).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: selectedDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  _newTransactionBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id){
  setState(() {
  _userTransaction.removeWhere((tx) =>  tx.id==id);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Planner App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (() => _newTransactionBottomSheet(context)),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('Show Chart'),
            Switch(value: showChart, onChanged: (val){
              showChart = val;
            })
          ],),
          Chart(_recentTransactions),
          _userTransaction.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Text('No transactions added yet!'),
                      SizedBox(height: 40),
                      Image.asset(
                        
                        'assets/images/waiting.png',
                        width: 300,
                        height: 300,
                       
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    TransactionList(_userTransaction, _deleteTransaction),
                  ],
                ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() => _newTransactionBottomSheet(context))),
    );
  }
}
