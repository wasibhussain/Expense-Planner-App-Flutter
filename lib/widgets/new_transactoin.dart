import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime? choosenDate;
  void submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || choosenDate==null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, choosenDate);
    Navigator.of(context).pop();
  }

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  _selectDate(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).then((pickedDate){
      if(pickedDate==null){
        return;
      }
       setState(() {
       choosenDate = pickedDate ;
    });
    });
   
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(choosenDate==null? 'No date choosen!' : 'Picked Date: ${DateFormat.yMd().format(choosenDate!)}'),
                  TextButton(onPressed: _selectDate, child: Text('Choose Date'))
                ],
    
              ),
              ElevatedButton(
                  onPressed: submitData, child: const Text('Add Transaction'))
            ],
            
          ),
        ),
      ),
    );
  }
}
