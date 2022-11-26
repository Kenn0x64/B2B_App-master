import 'package:main_branch/con/HTTP.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../.server.dart';

class Request {
  final String? productName;
  final double? productCapacity;
  final String? id;
  final String? product;
  final double requestedCapacity;
  static final List<String> status = ['Rejected', 'Accepted', 'Pending'];
  final int currntStatus;

  static String collectionName = 'requests';
  late DbCollection productCollection;

  Request({
    this.id,
    this.productName,
    this.productCapacity,
    required this.product,
    required this.currntStatus,
    required this.requestedCapacity,
  });

  factory Request.fromJson(Map<String, dynamic> data) {
    return Request(
        id: data['_id'],
        product: data['product']['_id'],
        productName: data['product']['productName'],
        productCapacity: data['product']['capacity'],
        currntStatus: data['status'],
        requestedCapacity: data['requestedCapacity']);
  }

  Map<String, String> toJson(bool needid) {
    if (needid) {
      return {
        '_id': id.toString(),
        'product': product.toString(),
        'status': currntStatus.toString(),
        'requestedCapacity': requestedCapacity.toString()
      };
    }
    return {
      'product': product.toString(),
      'status': currntStatus.toString(),
      'requestedCapacity': requestedCapacity.toString()
    };
  }

  Map<String, dynamic> toJsonDynamic() {
    return {
      'product': product,
      'status': currntStatus,
      'requestedCapacity': requestedCapacity
    };
  }

  Future<void> makeRequest() async {
    HTTP hp = HTTP(
        URI: '$server/requests/new', BODY: toJson(false));
    await hp.POST();
  }

  static Future<void> updateStatus(String id,int status) async {
    HTTP hp = HTTP(URI: "$server/requests/$id/$status");
    await hp.GET();
  }

  static Future<dynamic> getRequests() async {
    HTTP hp = HTTP(URI: '$server/requests');
    return await hp.GET();
  }
}
