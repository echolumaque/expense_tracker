import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // TextEditingController is like a binding for the contents of TextField in SwiftUI and Xamarin.
  // Basically, it gives you control to the TextField it is attached to
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    // "dispose", like "initState" and "build", is part of a StatefulWidget's lifecycle.
    // It is called automatically by Flutter when the widget & its state are about to be destroted.
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: "\$",
              label: Text("Amount"),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_amountController.text);
                  print(_titleController.text);
                },
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
