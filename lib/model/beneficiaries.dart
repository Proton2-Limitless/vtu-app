import 'package:flutter/material.dart';

enum VtuType { mtn, glo, airtel, mobile }

List<Color> containerColors(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? [
            Colors.black,
            Colors.red,
            const Color.fromARGB(255, 71, 227, 229),
            const Color.fromARGB(255, 117, 83, 186)
          ]
        : [
            const Color.fromARGB(255, 71, 227, 229),
            Colors.pink,
            Colors.green,
            Colors.deepPurple,
          ];

class Beneficiaries {
  const Beneficiaries({
    required this.name,
    required this.color,
    required this.number,
    required this.vtuType,
  });
  final String name;
  final Color color;
  final String number;
  final VtuType vtuType;
}

List<Beneficiaries> dummyBeneficiary(BuildContext context) => [
      Beneficiaries(
        name: "All",
        color: containerColors(context)[0],
        number: "09027690342",
        vtuType: VtuType.mtn,
      ),
      Beneficiaries(
        name: "name",
        color: containerColors(context)[1],
        number: "09027690342",
        vtuType: VtuType.airtel,
      ),
      Beneficiaries(
        name: "name1",
        color: containerColors(context)[2],
        number: "09027690342",
        vtuType: VtuType.glo,
      ),
      Beneficiaries(
        name: "name2",
        color: containerColors(context)[3],
        number: "09027690342",
        vtuType: VtuType.mobile,
      ),
    ];
