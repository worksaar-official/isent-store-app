import 'package:sixam_mart_store/features/deliveryman/controllers/deliveryman_controller.dart';
import 'package:sixam_mart_store/features/deliveryman/domain/models/delivery_man_model.dart';
import 'package:sixam_mart_store/helper/price_converter_helper.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/util/images.dart';
import 'package:sixam_mart_store/util/styles.dart';
import 'package:sixam_mart_store/common/widgets/confirmation_dialog_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_image_widget.dart';
import 'package:sixam_mart_store/features/deliveryman/widgets/amount_card_widget.dart';
import 'package:sixam_mart_store/features/store/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryManDetailsScreen extends StatelessWidget {
  final DeliveryManModel deliveryMan;
  const DeliveryManDetailsScreen({super.key, required this.deliveryMan});

  @override
  Widget build(BuildContext context) {
    Get.find<DeliveryManController>().setSuspended(!deliveryMan.status!);
    Get.find<DeliveryManController>().getDeliveryManReviewList(deliveryMan.id);

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'delivery_man_details'.tr),
      body: GetBuilder<DeliveryManController>(builder: (dmController) {
        return Column(children: [

          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Row(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: deliveryMan.active == 1 ? Colors.green : Colors.red, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(child: CustomImageWidget(
                    image: '${deliveryMan.imageFullUrl}',
                    height: 70, width: 70, fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${deliveryMan.fName} ${deliveryMan.lName}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    deliveryMan.active == 1 ? 'online'.tr : 'offline'.tr,
                    style: robotoRegular.copyWith(
                      color: deliveryMan.active == 1 ? Colors.green : Colors.red, fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Row(children: [
                    Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
                    Text(deliveryMan.avgRating!.toStringAsFixed(1), style: robotoRegular),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(
                      '${deliveryMan.ratingCount} ${'ratings'.tr}',
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                    ),
                  ]),
                ])),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Row(children: [
                AmountCardWidget(
                  title: 'total_delivered_order'.tr,
                  value: deliveryMan.ordersCount.toString(),
                  color: const Color(0xFF377DFF),
                ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                AmountCardWidget(
                  title: 'cash_in_hand'.tr,
                  value: PriceConverterHelper.convertPrice(deliveryMan.cashInHands),
                  color: const Color(0xFF132144),
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('reviews'.tr, style: robotoMedium),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  dmController.dmReviewList != null ? dmController.dmReviewList!.isNotEmpty ? ListView.builder(
                    itemCount: dmController.dmReviewList!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ReviewWidget(
                        review: dmController.dmReviewList![index], fromStore: false,
                        hasDivider: index != dmController.dmReviewList!.length-1,
                      );
                    },
                  ) : Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Center(child: Text(
                      'no_review_found'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
                    )),
                  ) : const Padding(
                    padding: EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),

            ]),
          )),

          CustomButtonWidget(
            onPressed: () {
              Get.dialog(ConfirmationDialogWidget(
                icon: Images.warning,
                description: dmController.isSuspended ? 'are_you_sure_want_to_un_suspend_this_delivery_man'.tr
                    : 'are_you_sure_want_to_suspend_this_delivery_man'.tr,
                onYesPressed: () => dmController.toggleSuspension(deliveryMan.id),
              ));
            },
            buttonText: dmController.isSuspended ? 'un_suspend_this_delivery_man'.tr : 'suspend_this_delivery_man'.tr,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            color: dmController.isSuspended ? Colors.green : Colors.red,
          ),

        ]);
      }),
    );
  }
}
