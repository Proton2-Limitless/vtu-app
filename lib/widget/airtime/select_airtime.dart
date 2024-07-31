import 'package:flutter/material.dart';
// import 'package:vtu_client/model/beneficiaries.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class SelectNetwork extends StatefulWidget {
  const SelectNetwork({super.key, required this.selectNetwork});

  final void Function(String name, String imageStr, Color color) selectNetwork;

  @override
  State<SelectNetwork> createState() => _SelectNetworkState();
}

class _SelectNetworkState extends State<SelectNetwork> {
  List<String> airtimeTypes = [
    "MTN",
    "Glo",
    "Airtel",
    "m_9mobile",
  ];

  Map<String, Color> airtimeColors = {
    "MTN": const Color.fromARGB(243, 236, 217, 49),
    "Glo": const Color.fromARGB(255, 77, 236, 49),
    "Airtel": const Color.fromARGB(243, 243, 51, 90),
    "m_9mobile": const Color.fromARGB(253, 3, 3, 3),
  };

  String selectedNetwork = "";
  @override
  Widget build(BuildContext context) {
    String processImage(String name) => "assets/images/$name.png";
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 14,
      ),
      width: double.infinity,
      color: containerColor(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: airtimeTypes
            .map(
              (airt) => InkWell(
                onTap: () {
                  widget.selectNetwork(
                    airt,
                    processImage(airt),
                    airtimeColors[airt]!,
                  );
                  setState(() {
                    selectedNetwork = airt;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: selectedNetwork == airt
                        ? airtimeColors[airt]!.withOpacity(0.1)
                        : null,
                    border: Border.all(
                      width: 1,
                      color: selectedNetwork == airt
                          ? airtimeColors[airt]!
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: width(context) * 0.2,
                  child: Column(
                    children: [
                      Image.asset(
                        processImage(airt),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        airt != "m_9mobile"
                            ? airt.toUpperCase()
                            : airt.substring(2).toUpperCase(),
                        style: fadeTextStyle(fsize: 13, context).copyWith(
                          color: airtimeColors[airt],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
