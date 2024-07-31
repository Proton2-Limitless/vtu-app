import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/model/other_services.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class CustomDialogPackage extends StatefulWidget {
  final String heading;
  final String selectedPackage;
  final List<Cables> data;
  final Function(String text, double? price) tap;

  const CustomDialogPackage({
    super.key,
    required this.heading,
    required this.selectedPackage,
    required this.data,
    required this.tap,
  });

  @override
  State<CustomDialogPackage> createState() => _CustomDialogPackageState();
}

class _CustomDialogPackageState extends State<CustomDialogPackage> {
  late String updateSelectPacksge;
  @override
  void initState() {
    updateSelectPacksge = widget.selectedPackage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      height: 350,
      child: Column(
        children: [
          Text(
            widget.heading,
            style: fadeTextStyle(context).copyWith(
              color: customColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final plan = widget.data[index];
                final text = plan.packageName;
                return ListTile(
                  minVerticalPadding: 0,
                  title: Text(
                    text,
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      color: updateSelectPacksge == text
                          ? customColor(context)
                          : null,
                      fontWeight:
                          updateSelectPacksge == text ? FontWeight.bold : null,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      updateSelectPacksge = text;
                    });
                    widget.tap(text, plan.packageAmount);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    widget.tap(updateSelectPacksge, null);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: fadeTextStyle(context).copyWith(
                      color: customColor(context).withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Proceed",
                    style: fadeTextStyle(context).copyWith(
                      color: customColor(context).withGreen(255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
