import '../data/data_sources/product_data_source.dart';
import '../model/product_model.dart';

class ProductRepository {
  static final List<ProductModel> _products = ProductDataSource.fetchProducts();

  static List<ProductModel> allProducts() => _products;

  static List<ProductModel> promoBannerProducts() =>
      _products.where((p) => p.isPromoBanner).toList();

  static List<ProductModel> hotSelling() =>
      _products.where((p) => p.isTopSeller).toList();

  static List<ProductModel> recommended() =>
      _products.where((p) => p.isRecommended).toList();

  static List<ProductModel> dealOfTheDay() =>
      _products.where((p) => p.isDealOfTheDay).toList();

  static List<ProductModel> search(String query) => _products
      .where((p) => p.title!.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
