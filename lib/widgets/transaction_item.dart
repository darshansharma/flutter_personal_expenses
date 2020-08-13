import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                '\u20B9${transaction.amount}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                label: Text('Delete'),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTransaction(transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
