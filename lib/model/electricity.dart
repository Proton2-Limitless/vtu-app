import 'dart:convert';

import 'package:http/http.dart' as http;

class Electricity {
  const Electricity({
    required this.identifier,
    required this.name,
  });

  final String identifier;
  final String name;
}

List<Electricity> availableElectric = [
  const Electricity(
      identifier: "ABUJA_ELECTRIC", name: "Abuja Electric - AEDC"),
  const Electricity(identifier: "KANO_ELECTRIC", name: "Kano Electric - KEDC"),
  const Electricity(identifier: "JOS_ELECTRIC", name: "Jos Electric - JEDC"),
  const Electricity(
    identifier: "Kaduna_ELECTRIC",
    name: "Kaduna Electric - KAEDC",
  ),
  const Electricity(identifier: "YOLA_ELECTRIC", name: "YOLA Electric - YEDC")
];

Future<Map<String, dynamic>> fetchAllElectricty() async {
  final url =
      Uri.parse('https://www.nellobytesystems.com/APIElectricityDiscosV1.asp');
  final response = await http.get(url);
  Map<String, dynamic> returnedVal = {};

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    returnedVal = jsonResponse["ELECTRIC_COMPANY"];
  }
  return returnedVal;
}
