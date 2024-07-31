import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/utils/constant_widget.dart';

showCustomDialog(
  BuildContext context, {
  required String image,
  required String airtime,
  required String amount,
  required String phoneNumber,
  required Color airtimeColor,
  String? description,
  required double height,
}) {
  customDialogBox(
    context,
    Container(
      padding: const EdgeInsets.all(20.0),
      height: height,
      child: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Network:",
                  style: fadeTextStyle(
                    context,
                  ).copyWith(color: customColor(context)),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    child: Image.asset(
                      image,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Text(
                      airtime.toUpperCase(),
                      style: fadeTextStyle(
                        context,
                      ).copyWith(
                        color: airtimeColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          description != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Description:",
                      style: fadeTextStyle(
                        context,
                      ).copyWith(color: customColor(context)),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: GoogleFonts.aBeeZee().fontFamily,
                          fontSize: 14,
                          color: customColor(context),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount:",
                style: fadeTextStyle(
                  context,
                ).copyWith(color: customColor(context)),
              ),
              RichText(
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
                      text: amount,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Number:",
                style: fadeTextStyle(
                  context,
                ).copyWith(color: customColor(context)),
              ),
              Text(
                phoneNumber,
                style: fadeTextStyle(
                  context,
                ).copyWith(color: customColor(context)),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
