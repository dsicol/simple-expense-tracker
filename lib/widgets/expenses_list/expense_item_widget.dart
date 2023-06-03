import 'package:expense_tracker/models/expense_categories.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({
    super.key,
    required this.expense
  });

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Spacer takes up all the remaining space between widgets
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
        ]
        )
      )
    );
  }

}