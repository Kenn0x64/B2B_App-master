// ignore_for_file: unnecessary_this

import 'package:main_branch/con/HTTP.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../server.dart';

class Product {
  final int price;
  final String? id;
  final String productName;
  final double capacity;
  static String collectionName = 'products';
  late DbCollection productCollection;

  Product({
    this.id,
    required this.price,
    required this.productName,
    required this.capacity,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
        price:data['price'],
        id: data['_id'],
        productName: data['productName'],
        capacity: data['capacity']);
  }

  Map<String, String> toJson(bool id) {
    if (id) {
      return {
        '_id': this.id.toString(),
        'price':this.price.toString(),
        'productName': this.productName,
        'capacity': this.capacity.round().toString(),
      };
    }
    return {
      'productName': this.productName,
      'price':this.price.toString(),
      'capacity': this.capacity.round().toString(),
    };
  }

  Map<String, dynamic> toJsonDynamic() {
    return {
      'price':this.price,
      'productName': this.productName,
      'capacity': this.capacity,
    };
  }

  Future<void> addItem() async {
    HTTP hp = HTTP(URI: '$server/products/new', BODY: toJson(false));
    await hp.POST();
  }

  static Future<void> deleteItem(String id) async {
    HTTP hp = HTTP(URI: "$server/products/delete/$id");
    await hp.GET();
  }

  static Future<dynamic> getProducts() async {
    HTTP hp = HTTP(URI: '$server/products/');
    return await hp.GET();
  }

  static Future<dynamic> reset() async {
    HTTP hp = HTTP(URI: '$server/reset');
    return await hp.GET();
  }
}
