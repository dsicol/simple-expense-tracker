import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_tracker/models/expense_categories.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMMMd();

class Expense {
  final String id;
  final String title;
  final Category category;
  final double amount;
  final DateTime date;

  Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.date
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses
  });

  // Utility or convenience constructor
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses.where(
      (expense) => expense.category == category
    ).toList();


  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

}