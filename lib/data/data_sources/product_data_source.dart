import '../../model/product_model.dart';

class ProductDataSource {
  static List<ProductModel> fetchProducts() {
    return [
      // ---- Promo Banners
      ProductModel(
        image: 'assets/images/banner1.jpg',
        title: 'Promo Banner 1',
        isPromoBanner: true,
      ),
      ProductModel(
        image: 'assets/images/banner2.jpg',
        title: 'Promo Banner 2',
        isPromoBanner: true,
      ),
      ProductModel(
        image: 'assets/images/banner3.jpg',
        title: 'Promo Banner 3',
        isPromoBanner: true,
      ),
      ProductModel(
        image: 'assets/images/banner4.jpg',
        title: 'Promo Banner 4',
        isPromoBanner: true,
      ),

      // Hot Selling Footwear

      ProductModel(
        image: 'assets/images/deal1.jpg',
        title: 'Running Shoes',
        discountLabel: 'Upto 40% OFF',
        isDealOfTheDay: true,
        category: 'Fashion',
        subCategory: 'Footwear',
      ),
      ProductModel(
        image: 'assets/images/deal2.jpg',
        title: 'Sneakers',
        discountLabel: '40-60% OFF',
        isDealOfTheDay: true,
      ),
      ProductModel(
        image: 'assets/images/deal3.jpg',
        title: 'Wrist Watches',
        discountLabel: 'Upto 40% OFF',
        isDealOfTheDay: true,
      ),
      ProductModel(
        image: 'assets/images/deal4.jpg',
        title: 'Bluetooth Speakers',
        discountLabel: '40-60% OFF',
        isDealOfTheDay: true,
      ),

      ProductModel(
        image: 'assets/images/shoe1.jpg',
        title: 'Adidas white sneakers for men',
        price: 68,
        originalPrice: 136,
        rating: 4.8,
        reviews: 692,
        isTopSeller: true,
        isFavorite: true,
      ),
      ProductModel(
        image: 'assets/images/shoe2.jpg',
        title: 'Nike black running shoes for men',
        price: 75,
        originalPrice: 90,
        rating: 4.2,
        isTopSeller: true,
        reviews: 412,
      ),
      ProductModel(
        image: 'assets/images/shoe2.jpg',
        title: 'Nike black running shoes for men',
        price: 75,
        originalPrice: 90,
        rating: 4.2,
        isTopSeller: true,
        reviews: 412,
      ),
//
      ProductModel(
        image: 'assets/images/shirt1.jpg',
        title: 'Allen Solly Regular fit cotton shirt',
        price: 35,
        originalPrice: 40.25,
        rating: 4.4,
        reviews: 412,
        isRecommended: true,
        isFavorite: false,
      ),
      ProductModel(
        image: 'assets/images/shirt2.jpg',
        title: 'Calvin Clein Regular fit slim fit shirt',
        price: 52,
        originalPrice: 62.4,
        rating: 4.2,
        reviews: 214,
        isRecommended: true,
        isFavorite: true,
      ),
      ProductModel(
        image: 'assets/images/shirt2.jpg',
        title: 'Calvin Clein Regular fit slim fit shirt',
        price: 52,
        originalPrice: 62.4,
        rating: 4.2,
        reviews: 214,
        isRecommended: true,
        isFavorite: true,
      ),
      // outros produtos...
    ];
  }
}
