import 'package:sixam_mart_store/features/rental_module/profile/domain/models/taxi_profile_model.dart';
import 'package:sixam_mart_store/features/rental_module/provider/controllers/provider_controller.dart';
import 'package:sixam_mart_store/helper/date_converter_helper.dart';
import 'package:sixam_mart_store/util/dimensions.dart';
import 'package:sixam_mart_store/util/images.dart';
import 'package:sixam_mart_store/util/styles.dart';
import 'package:sixam_mart_store/common/widgets/confirmation_dialog_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_store/common/widgets/custom_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyTimeWidget extends StatelessWidget {
  final int weekDay;
  const DailyTimeWidget({super.key, required this.weekDay});

  @override
  Widget build(BuildContext context) {
    String? openingTime;
    String? closingTime;
    List<Schedules> scheduleList = [];
    for (var schedule in Get.find<ProviderController>().scheduleList!) {
      if(schedule.day == weekDay) {
        scheduleList.add(schedule);
      }
    }
    String dayString = weekDay == 1 ? 'monday' : weekDay == 2 ? 'tuesday' : weekDay == 3 ? 'wednesday' : weekDay == 4
        ? 'thursday' : weekDay == 5 ? 'friday' : weekDay == 6 ? 'saturday' : 'sunday';
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(children: [

        Expanded(flex: 3, child: Text(dayString.tr, style: robotoMedium)),

        Expanded(flex: 7, child: SizedBox(height: 60, child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: scheduleList.length+1,
          itemBuilder: (context, index) {

            if(index == scheduleList.length) {
              return InkWell(
                onTap: () => Get.dialog(Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [

                      Text(
                        '${'schedule_for'.tr} ${dayString.tr}',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      Row(children: [

                        Expanded(child: CustomTimePickerWidget(
                          title: 'open_time'.tr, time: openingTime,
                          onTimeChanged: (time) => openingTime = time,
                        )),
                        const SizedBox(width: Dimensions.paddingSizeSmall),

                        Expanded(child: CustomTimePickerWidget(
                          title: 'close_time'.tr, time: closingTime,
                          onTimeChanged: (time) => closingTime = time,
                        )),

                      ]),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      GetBuilder<ProviderController>(builder: (providerController) {
                        return providerController.scheduleLoading ? const Center(child: CircularProgressIndicator()) : Row(children: [

                          Expanded(child: TextButton(
                            onPressed: () => Get.back(),
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).disabledColor.withValues(alpha: 0.3), minimumSize: const Size(1170, 40), padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                            ),
                            child: Text(
                              'cancel'.tr, textAlign: TextAlign.center,
                              style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                            ),
                          )),
                          const SizedBox(width: Dimensions.paddingSizeLarge),

                          Expanded(child: CustomButtonWidget(
                            buttonText: 'add'.tr,
                            onPressed: () {
                              bool overlapped = false;
                              if(openingTime != null && closingTime != null) {
                                for(int index=0; index<scheduleList.length; index++) {
                                  if(_isUnderTime(scheduleList[index].openingTime!, openingTime!, closingTime)
                                      || _isUnderTime(scheduleList[index].closingTime!, openingTime!, closingTime)
                                      || _isUnderTime(openingTime!, scheduleList[index].openingTime!, scheduleList[index].closingTime)
                                      || _isUnderTime(closingTime!, scheduleList[index].openingTime!, scheduleList[index].closingTime)) {
                                    overlapped = true;
                                    break;
                                  }
                                }
                              }
                              if(openingTime == null) {
                                showCustomSnackBar('pick_start_time'.tr);
                              }else if(closingTime == null) {
                                showCustomSnackBar('pick_end_time'.tr);
                              }else if(DateConverterHelper.convertTimeToDateTime(openingTime!).isAfter(DateConverterHelper.convertTimeToDateTime(openingTime!))) {
                                showCustomSnackBar('closing_time_must_be_after_the_opening_time'.tr);
                              }else if(overlapped) {
                                showCustomSnackBar('this_schedule_is_overlapped'.tr);
                              }else {
                                providerController.addSchedule(Schedules(
                                  day: weekDay, openingTime: openingTime, closingTime: closingTime,
                                ));
                              }
                            },
                            height: 40,
                          )),

                        ]);
                      }),

                    ]),
                  ),
                ), barrierDismissible: false),
                child: Container(
                  height: 30, width: 25,
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  color: Theme.of(context).primaryColor,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
              child: Stack(clipBehavior: Clip.none, children: [

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!, width: 1),
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  alignment: Alignment.center,
                  child: Text(
                    '${DateConverterHelper.convertStringTimeToTime(scheduleList[index].openingTime!.substring(0, 5))} '
                        '- ${DateConverterHelper.convertStringTimeToTime(scheduleList[index].closingTime!.substring(0, 5))}',
                  ),
                ),

                Positioned(
                  right: -10, top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () => Get.dialog(ConfirmationDialogWidget(
                        icon: Images.warning, description: 'are_you_sure_to_delete_this_schedule'.tr,
                        onYesPressed: () => Get.find<ProviderController>().deleteSchedule(scheduleList[index].id),
                      ), barrierDismissible: false),
                      child: const Icon(Icons.cancel_outlined, color: Colors.red),
                    ),
                  ),
                ),

              ]),
            );
          },
        ))),

      ]),
    );
  }

  bool _isUnderTime(String time, String startTime, String? endTime) {
    return DateConverterHelper.convertTimeToDateTime(time).isAfter(DateConverterHelper.convertTimeToDateTime(startTime))
        && DateConverterHelper.convertTimeToDateTime(time).isBefore(DateConverterHelper.convertTimeToDateTime(endTime!));
  }
}
