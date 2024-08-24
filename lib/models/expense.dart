import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = new DateFormat('dd/MM/yyyy');
enum Category {food, travel, leisure, work}
const uuid = Uuid();
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,


};
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatterDate {
    return formatter.format(date);
  }
}
  class ExpenseBucket {
    const ExpenseBucket({
      required this.category,
      required this.expenses,
    });
    ExpenseBucket.forCategory(List<Expense> allExpense, this.category):
      expenses = allExpense.where((expense) => expense.category == category).toList();
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