import 'package:flutter/material.dart';

import '../../data/data_sources/category_data_source.dart';
import '../../data/data_sources/sub_category_data_source.dart';
import '../../model/category_model.dart';
import '../../model/subcategory_model.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = categories[selectedIndex];
    final currentSubcategories = subcategories[selectedCategory.label] ?? [];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          IconWithDot(icon: Icons.notifications_none),
          SizedBox(width: 16),
        ],
      ),
      drawer: SizedBox(
        width: 120,
        child: Drawer(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 32),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                  Navigator.pop(context); // Fecha o Drawer
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category.backgroundColor,
                          border: isSelected
                              ? Border.all(color: Colors.blue, width: 2)
                              : null,
                        ),
                        child: Icon(
                          category.icon,
                          size: 28,
                          color: isSelected ? Colors.blue : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: isSelected ? Colors.blue : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: currentSubcategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 170,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final sub = currentSubcategories[index];
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    sub.image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  sub.label,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class IconWithDot extends StatelessWidget {
  final IconData icon;

  const IconWithDot({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.black87),
          onPressed: () {},
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
