import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class CustomizedTapToShowBottomSheet extends StatelessWidget {
  const CustomizedTapToShowBottomSheet({
    super.key,
    required this.label,
    required this.onTap,
    required this.initialBtnLbl,
    required this.props,
  });

  final String label;
  final void Function() onTap;
  final String initialBtnLbl;
  final String props;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: fadeTextStyle(fsize: 16, context).copyWith(
            color: customColor(context).withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    props != initialBtnLbl ? props.toUpperCase() : props,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: fadeTextStyle(context).copyWith(
                      color: props == initialBtnLbl
                          ? Colors.grey[500]
                          : customColor(context),
                      fontWeight:
                          props == initialBtnLbl ? null : FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down_outlined),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
