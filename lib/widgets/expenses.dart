import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return expensesState();
  }
}

class expensesState extends State<Expenses> {
  final List<Expense> registerExpense = [
    Expense(
        title: 'Khóa học lập trình',
        amount: 1200000,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Đi xem phim',
        amount: 200000,
        date: DateTime.now(),
        category: Category.leisure),
      Expense(
        title: 'Đồ ăn trưa',
        amount: 150000,
        date: DateTime.now(),
        category: Category.food),
  ];

  void clickAddButtonExpenses() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      registerExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = registerExpense.indexOf(expense);
    setState(() {
      registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registerExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No data here please add more data!'),
    );
    if (registerExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: registerExpense,
        onRemoveExpense: removeExpense,
      );
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'),
            actions: [
              IconButton(
                onPressed: clickAddButtonExpenses,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: width < 600
              ? Column(children: [
                  Chart(expenses: registerExpense),
                  Expanded(
                    child: mainContent,
                  ),
                ])
              : Row(
                  children: [
                    Expanded(
                      child: Chart(expenses: registerExpense),
                    ),
                    Expanded(
                      child: mainContent,
                    ),
                  ],
                )),
    );
  }
}
