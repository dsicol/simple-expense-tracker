import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item_widget.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final void Function(Expense expense) removeExpense;

  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.removeExpense
  });

  @override
  Widget build(BuildContext context) {
    // Column Widget loads all data passed into the column at once
    //  slows down performance
    // ListView Widget is a SCROLLABLE Widget by default
    // ListView.build() Widget loads data upon view.
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.80),
          margin: EdgeInsets.symmetric(
            // Dismissible takes the dynamically determined margin of the card
            // Margin of the card comes from its theme
            horizontal: Theme.of(context).cardTheme.margin!.horizontal
          ),
          child: const Icon(Icons.delete_forever_outlined),
        ),
        onDismissed: (direction) {
          removeExpense(expensesList[index]);
        },
        child: ExpenseItem(
          expense: expensesList[index]
        )
      ),
      // index increments until itemCount
      itemCount: expensesList.length,
    );
  }

}