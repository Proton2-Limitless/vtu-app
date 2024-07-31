import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtu_client/screens/authorized/home_screen.dart';
import 'package:vtu_client/screens/authorized/services.dart';
import 'package:vtu_client/screens/authorized/settings.dart';

var format = NumberFormat.simpleCurrency(
  locale: Platform.localeName,
  name: "NGN",
);

Color scafoldColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900] ?? Colors.black12
        : Colors.grey[200] ?? Colors.white70;

Color containerColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

Color customColor(BuildContext context) =>
    Theme.of(context).colorScheme.onBackground;
Color secondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSecondary;

TextStyle customStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontFamily: GoogleFonts.aBeeZee().fontFamily,
    );
TextStyle fadeTextStyle(BuildContext context,
        {double fsize = 16, double opacity = 0.6}) =>
    TextStyle(
      fontSize: fsize,
      color: customColor(context).withOpacity(opacity),
      fontFamily: GoogleFonts.aBeeZee().fontFamily,
    );

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

void showLoadingDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    barrierColor: Colors.black54,
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 120,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return FadeTransition(
        opacity: animation1,
        child: child,
      );
    },
  );
}

void showCustomModalBottomSheet(
  BuildContext context, {
  required List<dynamic> datas,
  required String title,
  String? provider,
  String? meterType,
  required Function(String text) tap,
  required double sheetHeight,
}) {
  String typeDynamic = (provider ?? meterType)!;

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    isDismissible: false,
    builder: (context) => Material(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: datas.isNotEmpty ? sheetHeight : 100,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            datas.isNotEmpty ? const SizedBox(height: 20) : const SizedBox(),
            Text(
              title,
              style: fadeTextStyle(context).copyWith(
                color: customColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            datas.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: datas
                            .map(
                              (plan) => InkWell(
                                onTap: () {
                                  tap(plan);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  child: Text(
                                    plan.toString().toUpperCase(),
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.aBeeZee().fontFamily,
                                      fontSize: 20,
                                      color: typeDynamic == plan
                                          ? customColor(context)
                                          : customColor(context)
                                              .withOpacity(0.5),
                                      fontWeight: typeDynamic == plan
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : const SizedBox(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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
    ),
  );
}

void customDialogBox(BuildContext context, Widget child) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: child,
        ),
      );
    },
  );
}

void summaryDialog(
  BuildContext context,
  List<Map<String, dynamic>> summaryItem,
) {
  customDialogBox(
    context,
    Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 50),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.error_sharp,
                    size: 80,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: customColor(context),
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 17,
                    color: customColor(context),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Confirm Transaction",
            style: fadeTextStyle(
              context,
              fsize: 20,
            ).copyWith(
              color: customColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          ...summaryItem.map(
            (item) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item["key"]}:",
                  style: fadeTextStyle(
                    context,
                  ).copyWith(color: customColor(context)),
                ),
                item["key"] != "Price"
                    ? Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              item["value"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZee().fontFamily,
                                fontSize: 14,
                                color: customColor(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: format.currencySymbol,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: item["value"].toString(),
                              style: TextStyle(
                                fontFamily: GoogleFonts.aBeeZee().fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 10, 58, 131),
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "Complete",
                  style: fadeTextStyle(context).copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void loading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (context) {
      return const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    },
  );
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.addBeneficiary,
    required this.isBeneficiary,
  });

  final void Function() addBeneficiary;
  final bool isBeneficiary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: addBeneficiary,
          icon: Icon(
            isBeneficiary ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.green,
            size: 30,
          ),
        ),
        Text(
          "Add Beneficiary",
          style: TextStyle(
            color: customColor(context).withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

final List<Widget> bottomBarScreen = [
  const Services(),
  const HomeScreen(),
  const Settings(),
];

const listResetPin = "Reset Transaction PIN";
const listResetPassword = "Reset Password";
const listupgrade = "Upgrade Membership Plan";

const listHelp = "Help & Support";
const listAbout = "About RechargeNow";

const listbio = "Biometric Login";

List<List<Map<String, dynamic>>> listsData = [
  [
    {"title": listResetPin, "leading": Icons.key, "trailing": true},
    {
      "title": listResetPassword,
      "leading": Icons.lock_outline_rounded,
      "trailing": true
    },
    {"title": listupgrade, "leading": Icons.cases, "trailing": true},
  ],
  [
    {
      "title": listHelp,
      "leading": Icons.support_agent_outlined,
      "trailing": true
    },
    {"title": listAbout, "leading": Icons.info_rounded, "trailing": false},
  ],
  [
    {"title": listbio, "leading": Icons.fingerprint, "trailing": true},
  ],
];

// {enteredFullname: test test , enteredNumber: 08052525252, enteredEmail: test@gmail.com, enteredPassword: 090Habib#, enteredPin: 1237, role: Subscriber}
