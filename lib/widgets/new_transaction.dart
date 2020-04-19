import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // declare titleController TextEditingController
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // declare [DateTime]
  DateTime _selectedDate;

  void _submitData() {
    // check if textis filled
    if (_titleController.text.isEmpty) {
      return;
    }

    // get text value from textController
    final enteredTitle = _titleController.text;
    // parse double value
    final enteredAmount = double.parse(_amountController.text);

    // check if all data are filled
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

// automaically refactored because of addTransaction method which is putted out of class
// dart card get this method by using this trick widget.
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);

// close bottomSheet
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // open datePicker
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitData,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text('Add transaction')),
            ),
          ],
        ),
      ),
    );
  }
}
