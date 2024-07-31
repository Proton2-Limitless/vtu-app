import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class ServicesItem extends StatelessWidget {
  const ServicesItem({
    super.key,
    required this.width,
    required this.height,
    required this.imageStr,
    required this.itemName,
    required this.onPress,
  });

  final double width;
  final double height;
  final String imageStr;
  final String itemName;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    final itemColor = Theme.of(context).colorScheme.primary;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: secondaryColor(context),
        border: Border.all(
          width: 1,
          color: itemColor.withOpacity(0.5),
        ),
      ),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                imageStr,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            itemName,
            style: customStyle(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  width: 1,
                  color: customColor(context),
                ),
              ),
              fixedSize: Size(width * 0.7, 20),
              backgroundColor: secondaryColor(context),
              surfaceTintColor: secondaryColor(context),
              foregroundColor: customColor(context),
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 15,
                ),
                Text(
                  "Purchase",
                  style: TextStyle(
                    color: customColor(context),
                    fontSize: 12,
                    fontFamily: GoogleFonts.aBeeZee().fontFamily,
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
