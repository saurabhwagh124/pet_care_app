class ShopItem {
  String itemName;
  String description;
  String brand;
  String category;
  String recommendedFor;
  double reviewScore;
  int noOfReviews;
  double price;
  String photoUrl;
  double discount;
  double discountedPrice;

  ShopItem({
    required this.itemName,
    required this.description,
    required this.brand,
    required this.category,
    required this.recommendedFor,
    required this.reviewScore,
    required this.noOfReviews,
    required this.price,
    required this.photoUrl,
    required this.discount,
    required this.discountedPrice,
  });
}
