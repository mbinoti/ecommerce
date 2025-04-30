import 'package:flutter/material.dart';

class CategoryModel {
  final String label; // name category
  final IconData icon;
  final Color backgroundColor;

  CategoryModel(
      {required this.icon, required this.label, required this.backgroundColor});
}
