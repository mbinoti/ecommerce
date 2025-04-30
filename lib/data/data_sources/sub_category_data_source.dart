import '../../model/subcategory_model.dart';

final Map<String, List<SubCategoryModel>> subcategories = {
  'Fashion': [
    SubCategoryModel(
      label: 'Fashion',
      image: 'assets/images/mens.jpg',
      subCategory: 'Mens',
    ),
    SubCategoryModel(
        label: 'Fashion',
        image: 'assets/images/womens.jpg',
        subCategory: 'Womens'),
    SubCategoryModel(
      label: 'Fashion',
      image: 'assets/images/kids.jpg',
      subCategory: 'Kids',
    ),
  ],
  'Electronics': [],
  'Appliances': [],
  'Beauty': [],
  'Furniture': [],
};
