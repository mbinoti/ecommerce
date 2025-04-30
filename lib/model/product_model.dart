class ProductModel {
  final String? image;
  final String? title;
  final double? price;
  final double? originalPrice;
  final double? rating;
  final int? reviews;
  final bool isPromoBanner;
  final bool isTopSeller;
  final bool isFavorite;
  final bool isRecommended;
  final bool isHotSellingFootwear;
  final bool isDealOfTheDay;
  final String? category;
  final String? subCategory;
  final String? discountLabel;

  ProductModel({
    this.image,
    this.title,
    this.price,
    this.originalPrice,
    this.rating,
    this.reviews,
    this.isPromoBanner = false,
    this.isTopSeller = false,
    this.isFavorite = false,
    this.isRecommended = false,
    this.isHotSellingFootwear = false,
    this.isDealOfTheDay = false,
    this.category,
    this.subCategory,
    this.discountLabel,
  });
}
