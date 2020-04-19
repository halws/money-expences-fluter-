import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // inicializate titleController TextEditingController
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    // get text value from textController
    final enteredTitle = titleController.text;
    // parse double value
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

// automaically refactored because of addTransaction method which is putted out of class
// dart card get this method by using this trick widget.
    widget.addTransaction(enteredTitle, enteredAmount);

// close bottomSheet
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
                textColor: Colors.blueGrey,
                onPressed: submitData,
                child: Text('Add transaction')),
          ],
        ),
      ),
    );
  }
}
