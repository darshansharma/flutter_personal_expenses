import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    List<Map<String, Object>> groupedTransactions = [];
    for (int day = 0; day < 7; day++) {
      var weekDay = DateTime.now().subtract(Duration(days: day));
      var totalAmountSpent = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmountSpent += recentTransactions[i].amount;
        }
      }
      groupedTransactions.add({
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmountSpent,
      });
    }
    return groupedTransactions.reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Last 7 days Expenses',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: groupedTransactionValues.map((txData) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      txData['day'],
                      txData['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (txData['amount'] as double) / totalSpending,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
