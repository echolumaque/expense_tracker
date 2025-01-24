import 'package:expense_tracker/enums/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void addExpense(
    String title,
    double amount,
    DateTime date,
    Category category,
  ) {
    setState(() {
      _registeredExpenses.add(
        Expense(
          title: title,
          amount: amount,
          date: date,
          category: category,
        ),
      );
    });
  }

  void removeExpense(Expense expenseToRemove) {
    final expenseIndex = _registeredExpenses.indexOf(expenseToRemove);

    setState(() {
      _registeredExpenses.remove(expenseToRemove);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleteed."),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expenseToRemove);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (buildContext) => NewExpense(
        addExpense: addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _registeredExpenses.isEmpty
        ? const Center(
            child: Text("No expenses found. Start adding some!"),
          )
        : ExpensesList(
            expenses: _registeredExpenses,
            onExpenseRemove: removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
