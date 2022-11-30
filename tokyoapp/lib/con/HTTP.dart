// ignore_for_file: non_constant_identifier_names, unused_field, unnecessary_this, file_names
import 'package:http/http.dart' as http;
import 'dart:convert';

class HTTP {
  Uri? _URI;
  String URI;
  static Map<String, String> HEADERS = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
  String? _BODY;
  Map<String, String>? BODY;
  late http.Response response;

  HTTP({required this.URI, this.BODY}) {
    this._URI = Uri.parse(URI);
    this._BODY = jsonEncode(BODY);
  }

  getURI() => URI;
  getBODY() => _BODY;

  dynamic CRES(http.Response res) {
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("400 Error Code ");
    }
  }

  Future<dynamic> POST() async {
    response = await http.post(this._URI as Uri,
        headers: HTTP.HEADERS, body: this._BODY);
    return (CRES(response));
  }

  Future<dynamic> DELETE() async {
    response = await http.delete(this._URI as Uri,
        headers: HTTP.HEADERS, body: this._BODY);
    return (CRES(response));
  }

  Future<dynamic> GET() async {
    response = await http.get(this._URI as Uri, headers: HTTP.HEADERS);
    return (CRES(response));
  }
}
