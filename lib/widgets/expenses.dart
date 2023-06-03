import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/expense_categories.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list_widget.dart';
import 'package:expense_tracker/widgets/add_expense/add_expense_widget.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

const String appName = 'myLedge';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work
    ),
    Expense(title: 'Cinema',
        category: Category.leisure,
        amount: 12,
        date: DateTime.now())
  ];

  void _addExpenseWidget() {
    // context refers context of Expenses Widget
    // ctx refers to showModalBottomSheet context
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) =>
      AddExpenseWidget(onAddExpense: _addExpense)
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int targetExpenseIndex = _registeredExpenses.indexOf(expense);
    final Expense targetExpense = expense;

    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Clears any previous SnackBars before showing next
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                  targetExpenseIndex,
                  targetExpense
              );
            });
          },
        )
      )
    );
  }

  Widget manageExpenseScreen() {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start by adding some!')
    );

    bool isEmptyExpense = _registeredExpenses.isEmpty;

    if (!isEmptyExpense) {
      mainContent =  ExpensesList(
        expensesList: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return mainContent;
  }

  Widget renderDeviceOrientation(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    if (deviceWidth > deviceHeight) {
      return landscapeOrientation();
    }
    return portraitOrientation();
  }

  Widget portraitOrientation() {
    return Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: manageExpenseScreen())
        ]
    );
  }

  Widget landscapeOrientation() {
    return Row(
        children: [
          // Row and Chart takes double.infinity width
          //  Use Expanded() to keep it within bounds
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: manageExpenseScreen())
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
              onPressed: _addExpenseWidget,
              icon: const Icon(Icons.add)
          )
        ]
      ),
      body: renderDeviceOrientation(context)
    );
  }

}