import 'package:flutter/material.dart';

enum Category {
  food,
  travel,
  leisure,
  work
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.train_sharp,
  Category.leisure: Icons.movie_creation_sharp,
  Category.work: Icons.work
};