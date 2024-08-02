import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtu_client/utils/constant_widget.dart';
import 'package:vtu_client/widget/quick_access.dart';
import 'package:vtu_client/widget/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String refferalCode = "referral code";

    void copyreferralCode() async {
      try {
        await Clipboard.setData(ClipboardData(text: refferalCode));
        if (context.mounted) {
          showSnackBar(context, "Copied to Clipboard!");
        }
      } catch (e) {
        if (context.mounted) {
          showSnackBar(context, "Failed to copy to clipboard.");
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Material(
                          elevation: 5,
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 18,
                              bottom: 22,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Refferal Code",
                                  style: customStyle(context).copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: customColor(context),
                                  ),
                                ),
                                Text(
                                  "You earn 2% on every transaction your referral makes",
                                  style: fadeTextStyle(fsize: 16, context),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: customColor(context),
                                          ),
                                        ),
                                        child: Text(
                                          refferalCode,
                                          style:
                                              fadeTextStyle(fsize: 20, context)
                                                  .copyWith(
                                            color: customColor(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: copyreferralCode,
                                      child: Container(
                                        height: 53,
                                        padding: EdgeInsets.all(8),
                                        color: customColor(context)
                                            .withOpacity(0.9),
                                        child: Center(
                                          child: Text(
                                            "Copy Code",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Material(
                          elevation: 5,
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 15,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color:
                                          customColor(context).withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Quick Access",
                                  style: fadeTextStyle(fsize: 20, context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    QuickAccess(
                                      text: "Airtime",
                                      icon: Icons.phone,
                                      color: customColor(context).withBlue(220),
                                      onPress: () {},
                                    ),
                                    QuickAccess(
                                      text: "Data",
                                      icon: Icons.wifi,
                                      color: customColor(context).withRed(255),
                                      onPress: () {},
                                    ),
                                    QuickAccess(
                                      text: "Transfer",
                                      icon: Icons.money,
                                      color:
                                          customColor(context).withGreen(220),
                                      onPress: () {},
                                    ),
                                    QuickAccess(
                                      text: "Electricity",
                                      icon: Icons.electric_meter,
                                      color: customColor(context).withRed(100),
                                      onPress: () {},
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Transaction History",
                          style: fadeTextStyle(opacity: 0.9, fsize: 20, context)
                              .copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  sliver: SliverList.builder(
                    itemBuilder: (context, index) {
                      return Text(
                        "Transactions",
                        style: fadeTextStyle(fsize: 20, context),
                      );
                    },
                    itemCount: 3,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
