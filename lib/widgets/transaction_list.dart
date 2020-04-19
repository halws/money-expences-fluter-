import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        // TODO replace with dynamic calculation
        height: 440,
        child: userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transaction!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemCount: userTransactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                                '\$${userTransactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat('yyyy/MM/dd')
                          .format(userTransactions[index].date)),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTransaction(index)),
                    ),
                  );
                }));
  }
}
