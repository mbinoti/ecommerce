import 'package:flutter/material.dart';

import '../../model/category_model.dart';

final List<CategoryModel> categories = [
  CategoryModel(
      label: 'Fashion',
      icon: Icons.checkroom,
      backgroundColor: Colors.greenAccent.shade100),
  CategoryModel(
      label: 'Electronics',
      icon: Icons.laptop_mac,
      backgroundColor: Colors.orange.shade100),
  CategoryModel(
      label: 'Appliances',
      icon: Icons.kitchen,
      backgroundColor: Colors.green.shade100),
  CategoryModel(
      label: 'Beauty',
      icon: Icons.sanitizer,
      backgroundColor: Colors.lightBlue.shade100),
  CategoryModel(
      label: 'Furniture',
      icon: Icons.weekend,
      backgroundColor: Colors.blue.shade100),
];
