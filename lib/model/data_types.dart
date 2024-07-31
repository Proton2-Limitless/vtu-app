import 'dart:convert';
import 'package:http/http.dart' as http;

class DataType {
  const DataType({
    required this.dataId,
    required this.value,
    required this.price,
  });

  final String value;
  final String dataId;
  final double price;

  factory DataType.fromJson(Map<String, dynamic> json) {
    return DataType(
      value: json['PRODUCT_NAME'],
      dataId: json['PRODUCT_ID'],
      price: double.parse(json['PRODUCT_AMOUNT']),
    );
  }
}

Future<List<DataType>> fetchDatasPackages(String keyword) async {
  final url = Uri.parse(
      'https://www.nellobytesystems.com/APIDatabundlePlansV2.asp?UserID=CK100319808');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<DataType> packages = [];
    // print(jsonData["TV_ID"][keyword][0]["PRODUCT"]);
    final data = jsonData["MOBILE_NETWORK"][keyword][0]["PRODUCT"];

    data.forEach(
      (package) => packages.add(
        DataType.fromJson(package),
      ),
    );

    return packages;
  } else {
    throw Exception('Failed to load data');
  }
}
