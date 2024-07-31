import 'dart:convert';
import 'package:http/http.dart' as http;

class Cables {
  final String packageId;
  final String packageName;
  final double packageAmount;
  final double productDiscountAmount;
  final double productDiscount;

  const Cables({
    required this.packageId,
    required this.packageName,
    required this.packageAmount,
    required this.productDiscountAmount,
    required this.productDiscount,
  });

  factory Cables.fromJson(Map<String, dynamic> json) {
    return Cables(
      packageId: json['PACKAGE_ID'],
      packageName: json['PACKAGE_NAME'],
      packageAmount: double.parse(json['PACKAGE_AMOUNT']),
      productDiscountAmount: double.parse(json['PRODUCT_DISCOUNT_AMOUNT']),
      productDiscount: double.parse(json['PRODUCT_DISCOUNT']),
    );
  }
}

Future<List<Cables>> fetchCablesPackages(String keyword) async {
  final url =
      Uri.parse('https://www.nellobytesystems.com/APICableTVPackagesV2.asp');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<Cables> packages = [];
    // print(jsonData["TV_ID"][keyword][0]["PRODUCT"]);
    final data = jsonData["TV_ID"][keyword][0]["PRODUCT"];

    data.forEach(
      (package) => packages.add(
        Cables.fromJson(package),
      ),
    );

    return packages;
  } else {
    throw Exception('Failed to load data');
  }
}
