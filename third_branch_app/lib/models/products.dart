import 'package:main_branch/con/HTTP.dart';
import '../../server.dart';

class Product {
  final String? id;
  final String productName;
  final double capacity;
  static String collectionName = 'products';
  
  Product({
    this.id,
    required this.productName,
    required this.capacity,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
        id: data['_id'],
        productName: data['productName'],
        capacity: data['capacity']);
  }

  Map<String, String> toJson(bool id) {
    if (id) {
      return {
        '_id': this.id.toString(),
        'productName': productName,
        'capacity': capacity.round().toString(),
      };
    }
    return {
      'productName': productName,
      'capacity': capacity.round().toString(),
    };
  }

  Map<String, dynamic> toJsonDynamic() {
    return {
      'productName': productName,
      'capacity': capacity,
    };
  }

  Future<void> addItem() async {
    HTTP hp = HTTP(
        URI: '$server/products/new', BODY: toJson(false));
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
}
