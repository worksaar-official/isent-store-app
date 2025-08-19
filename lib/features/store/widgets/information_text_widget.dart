import 'package:flutter/material.dart';
import 'package:sixam_mart_store/common/widgets/details_custom_card.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/util/styles.dart';

class InformationTextWidget extends StatelessWidget {
  final String title;
  final String value;
  const InformationTextWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return DetailsCustomCard(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
      borderRadius: 0,
      isBorder: false,
      child: Column(children: [
        Row(children: [
          Expanded(
            flex: 3,
            child: Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          ),

          Expanded(
            flex: 7,
            child: Row(
              children: [
                Text(':', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Text(value, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
              ],
            ),
          ),

        ]),
      ]),
    );
  }
}