class Product {
    Product({
        required this.id,
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

    final int? id;
    final String? itemName;
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

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            itemName: json["itemName"],
            description: json["description"],
            brand: json["brand"],
            category: json["category"],
            recommendedFor: json["recommendedFor"],
            reviewScore: json["reviewScore"],
            noOfReviews: json["noOfReviews"],
            price: json["price"],
            photoUrl: json["photoUrl"],
            discount: json["discount"],
            discountedPrice: json["discountedPrice"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
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
    String toString(){
        return "$id, $itemName, $description, $brand, $category, $recommendedFor, $reviewScore, $noOfReviews, $price, $photoUrl, $discount, $discountedPrice, ";
    }
}