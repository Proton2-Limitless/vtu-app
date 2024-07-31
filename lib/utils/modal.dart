import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/model/data_types.dart';
import 'package:vtu_client/utils/constant_widget.dart';

customModal(
  BuildContext context,
  List<DataType> dataPlans,
  Function(String value, double price) tap,
  String selectedLabel,
  Function() changeIcon,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Material(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          height: dataPlans.isNotEmpty ? double.infinity : 100,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataPlans.isNotEmpty
                  ? const SizedBox(height: 20)
                  : const SizedBox(),
              Text(
                "Select Data Plan",
                style: fadeTextStyle(context).copyWith(
                  color: customColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              dataPlans.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: dataPlans.length,
                        itemBuilder: (context, index) {
                          final plan = dataPlans[index];
                          final text = "${plan.value} - N${plan.price}";
                          return ListTile(
                            title: Text(
                              text,
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZee().fontFamily,
                                color: selectedLabel == text
                                    ? customColor(context)
                                    : null,
                                fontWeight: selectedLabel == text
                                    ? FontWeight.bold
                                    : null,
                              ),
                            ),
                            onTap: () {
                              tap(text, plan.price);
                            },
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              GestureDetector(
                onTap: changeIcon,
                child: Text(
                  "Cancel",
                  style: fadeTextStyle(context).copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
