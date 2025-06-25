class Product {
  Product({
    required this.id,
    required this.itemName,
    this.quantity, // Added quantity, made optional for flexibility
    required this.description,
    required this.brand,
    required this.category,
    required this.recommendedFor,
    this.reviewScore,
    this.noOfReviews,
    required this.price,
    required this.photoUrl,
    this.discount,
    this.discountedPrice,
  });

  final int? id;
  final String? itemName;
  final int? quantity; // New field
  final String? description;
  final String? brand;
  final String? category;
  final String? recommendedFor;
  final double? reviewScore;
  final int? noOfReviews;
  final int? price;
  final String? photoUrl;
  final int? discount;
  final int? discountedPrice;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] as int?,
      itemName: json["itemName"] as String?,
      quantity: json["quantity"] as int?,
      // Added quantity mapping
      description: json["description"] as String?,
      brand: json["brand"] as String?,
      category: json["category"] as String?,
      recommendedFor: json["recommendedFor"] as String?,
      reviewScore: (json["reviewScore"] as num?)?.toDouble(),
      // Handle num to double
      noOfReviews: json["noOfReviews"] as int?,
      price: json["price"] as int?,
      photoUrl: json["photoUrl"] as String?,
      discount: json["discount"] as int?,
      discountedPrice: json["discountedPrice"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "quantity": quantity, // Added quantity to JSON output
        "description": description,
        "brand": brand,
        "category": category,
        "recommendedFor": recommendedFor,
        "reviewScore": reviewScore,
        "noOfReviews": noOfReviews,
        "price": price,
        "photoUrl": photoUrl,
        "discount": discount,
        "discountedPrice": discountedPrice,
      };

  @override
  String toString() {
    return "$id, $itemName, quantity: $quantity, $description, $brand, $category, $recommendedFor, $reviewScore, $noOfReviews, $price, $photoUrl, $discount, $discountedPrice, ";
  }

  // Optional: Add a copyWith method for easier object updates
  Product copyWith({
    int? id,
    String? itemName,
    int? quantity,
    String? description,
    String? brand,
    String? category,
    String? recommendedFor,
    double? reviewScore,
    int? noOfReviews,
    int? price,
    String? photoUrl,
    int? discount,
    int? discountedPrice,
  }) {
    return Product(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      recommendedFor: recommendedFor ?? this.recommendedFor,
      reviewScore: reviewScore ?? this.reviewScore,
      noOfReviews: noOfReviews ?? this.noOfReviews,
      price: price ?? this.price,
      photoUrl: photoUrl ?? this.photoUrl,
      discount: discount ?? this.discount,
      discountedPrice: discountedPrice ?? this.discountedPrice,
    );
  }
}
