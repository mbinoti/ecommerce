import 'package:faker/faker.dart' hide Image;
import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products = generateFakeProducts(20);

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, index) {
        final product = products[index];
        return ListTile(
          leading: Image.network(product.imageUrl),
          title: Text(product.name),
          subtitle: Text(
              '${product.description}\nR\$ ${product.price.toStringAsFixed(2)}'),
          isThreeLine: true,
        );
      },
    );
  }
}

List<Product> generateFakeProducts(int count) {
  final faker = Faker();

  return List.generate(count, (index) {
    return Product(
      name: faker.food.dish(),
      description: faker.lorem.sentences(2).join(' '),
      price: double.parse(
          (faker.randomGenerator.decimal() * 100).toStringAsFixed(2)),
      imageUrl: 'https://picsum.photos/seed/product$index/200/200',
    );
  });
}
