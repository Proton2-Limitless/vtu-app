import 'package:flutter/material.dart';
import 'package:vtu_client/screens/authorized/services/airtime.dart';
import 'package:vtu_client/screens/authorized/services/cable.dart';
import 'package:vtu_client/screens/authorized/services/data.dart';
import 'package:vtu_client/screens/authorized/services/electric.dart';
import 'package:vtu_client/screens/authorized/services/recharge_card.dart';
import 'package:vtu_client/screens/authorized/services/transfer.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/utils/service_item.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    String processImage(String name, String extension) =>
        "assets/images/$name-service$extension";
    double containerWidth = height(context) * 0.2;
    double containerheight = height(context) * 0.24;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("airtime", ".png"),
                itemName: "Airtime",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Airtime(),
                    ),
                  );
                },
              ),
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("data", ".jpg"),
                itemName: "Data",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Data(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("tv-cable", ".jpg"),
                itemName: "Cable TV",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Cable(),
                    ),
                  );
                },
              ),
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("electric", ".jpg"),
                itemName: "Electric",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Electric(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("cash", ".jpg"),
                itemName: "Transfer",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const TransferScreen(),
                    ),
                  );
                },
              ),
              ServicesItem(
                width: containerWidth,
                height: containerheight,
                imageStr: processImage("result", ".png"),
                itemName: "Print Cards",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const RechargeCard(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
