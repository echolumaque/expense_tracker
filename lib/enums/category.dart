import 'package:flutter/material.dart';

enum Category {
  food,
  travel,
  leisure,
  work,
}

extension CategoryExtension on Category {
  IconData get categoryIcon {
    return switch (this) {
      Category.food => Icons.lunch_dining,
      Category.travel => Icons.flight_takeoff,
      Category.leisure => Icons.movie,
      Category.work => Icons.work,
    };
  }
}
