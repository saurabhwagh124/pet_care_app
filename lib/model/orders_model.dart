import 'package:pet_care_app/model/address_model.dart';

class OrdersModel {
  OrdersModel({
    required this.id,
    required this.usersId,
    required this.orderItemsList,
    required this.totalPrice,
    required this.address,
    required this.remarks,
    required this.status,
    required this.createdAt,
  });

  final int? id;
  int? usersId;
  final List<OrderItemsList> orderItemsList;
  final int? totalPrice;
  final AddressModel? address;
  final String? remarks;
  final String? status;
  final DateTime? createdAt;

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json["id"],
      usersId: json["usersId"],
      orderItemsList: json["orderItemsList"] == null
          ? []
          : List<OrderItemsList>.from(
              json["orderItemsList"]!.map((x) => OrderItemsList.fromJson(x))),
      totalPrice: json["totalPrice"],
      address: json["address"] == null
          ? null
          : AddressModel.fromJson(json["address"]),
      remarks: json["remarks"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "usersId": usersId,
        "orderItemsList": orderItemsList.map((x) => x.toJson()).toList(),
        "totalPrice": totalPrice,
        "address": address?.toJson(),
        "remarks": remarks,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $usersId, $orderItemsList, $totalPrice, $address, $remarks, $status, $createdAt, ";
  }
}

class OrderItemsList {
  OrderItemsList({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.pricePerItem,
  });

  final int? id;
  final int? itemId;
  final int? quantity;
  final int? pricePerItem;

  factory OrderItemsList.fromJson(Map<String, dynamic> json) {
    return OrderItemsList(
      id: json["id"],
      itemId: json["itemId"],
      quantity: json["quantity"],
      pricePerItem: json["pricePerItem"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemId": itemId,
        "quantity": quantity,
        "pricePerItem": pricePerItem,
      };

  @override
  String toString() {
    return "$id, $itemId, $quantity, $pricePerItem, ";
  }
}
