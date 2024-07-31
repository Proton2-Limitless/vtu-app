import 'package:flutter/material.dart';
import 'package:vtu_client/model/beneficiaries.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class Beneficiaries extends StatelessWidget {
  const Beneficiaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 14,
      ),
      width: double.infinity,
      color: containerColor(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Beneficiaries",
            style: fadeTextStyle(fsize: 16, context).copyWith(
              color: customColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dummyBeneficiary(context)
                  .map(
                    (itm) => Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: itm.color,
                            radius: 20,
                            child: ClipOval(
                              child: itm.name == "All"
                                  ? Icon(
                                      Icons.person,
                                      size: 30,
                                      color: containerColor(context),
                                    )
                                  : Text(
                                      itm.name[0].toUpperCase(),
                                      style: fadeTextStyle(fsize: 24, context)
                                          .copyWith(
                                        color: containerColor(context),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          itm.name,
                          style: fadeTextStyle(fsize: 13, context).copyWith(
                            color: customColor(context),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
