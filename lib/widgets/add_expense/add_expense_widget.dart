import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/models/expense_categories.dart';


class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpenseWidget> createState() {
    return _AddExpenseWidgetState();
  }
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _newExpenseDate;
  Category? _selectedCategory;

  void _showDatePicker() async {
    final now = DateTime.now();
    final earliestDate = DateTime(now.year - 1, now.month, now.day);

    // line of code after await runs after value has been assigned to the var.
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: earliestDate,
        lastDate: now
    );

    setState(() {
      _newExpenseDate = selectedDate;
    });
  }

  void _submitExpense() {
    // Null if cannot be converted to double
    final bool isValidTitle = (_titleController.text.trim().isNotEmpty);
    final double? expenseAmount = double.tryParse(_amountController.text);
    final bool isValidAmount = ((expenseAmount != null) && (expenseAmount > 0));
    final bool isValidCategory = (_selectedCategory != null);
    final bool isValidDate = (_newExpenseDate != null);
    if (!isValidTitle || !isValidCategory || !isValidAmount || !isValidDate) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
                'Invalid input'
            ),
            content: const Text(
                'Please enter a valid title, amount, date and category'
            ),
            actions: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                          'Got it!'
                      )
                  )
              )
            ],
          )
      );
      return;
    }
    // widget accesses connected widget class
    widget.onAddExpense(
        Expense(
            title: _titleController.text,
            category: _selectedCategory!,
            amount: expenseAmount,
            date: _newExpenseDate!
        )
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // _titleController stays in memory - needs to dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;

      return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              if (maxWidth >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              label: Text('Expense title')
                          ),
                        )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Expense amount')
                          ),
                        )
                    )
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      label: Text('Expense title')
                  ),
                ),
              if (maxWidth >= 600)
                Row(
                  children: [
                    DropdownButton(
                      // value shows selected category
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                                (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())
                            )
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                (_newExpenseDate == null) ? 'No date selected'
                                    : dateFormatter.format(_newExpenseDate!)
                            ),
                            IconButton(
                                onPressed: _showDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        )
                    )
                  ],
                )
              else
                Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                prefixText: '\$',
                                label: Text('Expense amount')
                            ),
                          )
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  (_newExpenseDate == null) ? 'No date selected'
                                      : dateFormatter.format(_newExpenseDate!)
                              ),
                              IconButton(
                                  onPressed: _showDatePicker,
                                  icon: const Icon(Icons.calendar_month))
                            ],
                          )
                      )
                    ]
                ),
              const SizedBox(height: 20),
              if (maxWidth >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text('Save Expense')
                    )
                  ],
                )
              else
                Row(
                  children: [
                    DropdownButton(
                      // value shows selected category
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                                (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())
                            )
                        ).toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text('Save Expense')
                    ),
                  ],
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined),
              )
            ],
          )
      );
    });
  }

}