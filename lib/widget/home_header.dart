import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtu_client/screens/authorized/deposit.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _hide = false;

  void _hideOrShowBalance() {
    setState(() {
      _hide = !_hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: "NGN");

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(name)
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "Welcome, Habib Yusuf",
                    style: TextStyle(
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontSize: 20,
                    ),
                    // softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("My Wallet Ballance"),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !_hide
                          ? RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: format.currencySymbol,
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                                TextSpan(
                                  text: "24,000.00",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.aBeeZee().fontFamily,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                            )
                          : Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                Icon(
                                  Icons.circle,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                Icon(
                                  Icons.circle,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                Icon(
                                  Icons.circle,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ],
                            ),
                      IconButton(
                        onPressed: _hideOrShowBalance,
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 35,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Deposit(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              width: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -45,
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                  ),
                  Text(
                    "Deposit",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontFamily: GoogleFonts.aBeeZee().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
