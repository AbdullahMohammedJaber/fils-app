import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/search/store/dialog_show_category.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/widget_form.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/manage_file_widget/manage_file_widget.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAddAuctionCoustomer extends StatefulWidget {
  const FormAddAuctionCoustomer({super.key});

  @override
  State<FormAddAuctionCoustomer> createState() =>
      _FormAddAuctionCoustomerState();
}

class _FormAddAuctionCoustomerState extends State<FormAddAuctionCoustomer> {
  final _key = GlobalKey<FormState>();
  TextEditingController auctionName = TextEditingController();
  TextEditingController auctionPrice = TextEditingController();
  TextEditingController auctionDescreption = TextEditingController();
  TextEditingController auctionFee = TextEditingController();
  DateTime dataStart = DateTime.now();
  DateTime dataEnd = DateTime.now();
  TimeOfDay timeStart = TimeOfDay.now();
  TimeOfDay timeEnd = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<AuctionCubit>();
        return Scaffold(
          appBar: AppBar(toolbarHeight: 1),
          body: Form(
            key: _key,

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.06, width: width),
                    ItemTitleBar(title: "Add Auction".tr(), canBack: true),
                    SizedBox(height: heigth * 0.04),
                    faildFormProduct(
                      context,
                      controller: auctionName,
                      title: "Auction Name",
                      pathIcon: "assets/icons/product_name.svg",
                      validator: (p0) {
                        if (auctionName.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      controller: auctionPrice,
                      isDouble: true,
                      textInputType: TextInputType.phone,
                      title: "Initial price",
                      pathIcon: "assets/icons/product_price.svg",
                      validator: (p0) {
                        if (auctionPrice.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      isDouble: true,
                      textInputType: TextInputType.phone,
                      controller: auctionFee,
                       validator: (p0) {
                        if (auctionFee.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                      title: "Assurance Fee",
                      pathIcon: "assets/icons/product_price.svg",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Category".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (state.idCategory == null) {
                              return StringApp.requiredField;
                            }
                            return null;
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            hintText: state.nameCategory ?? "Category".tr(),
                            pathIconPrefix: "assets/icons/add_cir.svg",
                            isIcon: true,
                            textInputType: TextInputType.none,
                            onTap: () {
                              showCupertinoDialog(
                                context: context,
                                builder:
                                    (context) => DialogShowCategory(
                                      callback: (item) {
                                        controller.changeCategoryData(
                                          id: item.id,
                                          name: item.name,
                                        );
                                      },
                                    ),
                              );
                            },
                            pathIcon: "assets/icons/drob.svg",
                          ),
                        ),
                      ],
                    ),
                    if (state.idCategory != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: heigth * 0.02),
                          DefaultText(
                            "Sub Category".tr(),
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          SizedBox(width: width, height: heigth * 0.01),
                          ValidateWidget(
                            validator: (value) {
                              if (state.categoresId == null) {
                                return StringApp.requiredField;
                              }
                              return null;
                            },
                            child: TextFormFieldWidget(
                              isPreffix: true,
                              hintText: state.nameCategores ?? "Sub Category".tr(),
                              pathIconPrefix: "assets/icons/add_cir.svg",
                              isIcon: true,
                              textInputType: TextInputType.none,
                              onTap: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder:
                                      (context) => DialogShowMultiCategory(
                                        callback: (ids) {
                                          controller
                                              .functionChangeCategoryListData(
                                                ids,
                                              );
                                        },
                                        categoryId: state.idCategory!,
                                      ),
                                );
                              },
                              pathIcon: "assets/icons/drob.svg",
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: heigth * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "Start Date".tr(),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              SizedBox(width: width, height: heigth * 0.01),
                              ValidateWidget(
                                validator: (value) {
                                  return null;
                                },
                                child: TextFormFieldWidget(
                                  isPreffix: true,
                                  hintText: formatDate2(dataStart),
                                  pathIconPrefix: "assets/icons/calendar.svg",
                                  onTap: () async {
                                    selectStartDate();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "End Date".tr(),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              SizedBox(width: width, height: heigth * 0.01),
                              ValidateWidget(
                                validator: (value) {
                                  return null;
                                },
                                child: TextFormFieldWidget(
                                  isPreffix: true,
                                  onTap: () {
                                    selectEndDate();
                                  },
                                  hintText: formatDate2(dataEnd),
                                  pathIconPrefix: "assets/icons/calendar.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "Start Time".tr(),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              SizedBox(width: width, height: heigth * 0.01),
                              ValidateWidget(
                                validator: (value) {
                                  return null;
                                },
                                child: TextFormFieldWidget(
                                  isPreffix: true,
                                  onTap: () {
                                    selectStartTime(context);
                                  },
                                  hintText: formatTimeOfDay2(timeStart),
                                  pathIconPrefix: "assets/icons/clock.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "End Time".tr(),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              SizedBox(width: width, height: heigth * 0.01),
                              ValidateWidget(
                                validator: (value) {
                                  return null;
                                },
                                child: TextFormFieldWidget(
                                  isPreffix: true,
                                  onTap: () {
                                    selectEndTime(context);
                                  },
                                  hintText: formatTimeOfDay2(timeEnd),
                                  pathIconPrefix: "assets/icons/clock.svg",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    // Upload Product Image Done
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DefaultText(
                              "Upload Product image".tr(),
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            DefaultText(
                              " * ".tr(),
                              color: error40,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        SizedBox(width: width, height: heigth * 0.02),
                        AnimatedImagePickerFormField(
                          image: state.imageProduct,
                          isLoading: false,
                          height: heigth * 0.2,
                          width: width,
                          label: "product image".tr(),
                          onPickImage: () {
                            controller.functionSelectImage(context);
                          },
                          onRemoveImage: () {
                            controller.clearAttachment();
                          },
                          validator: (file) {
                            if (file == null) {
                              return StringApp.requiredField;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),

                    faildFormProduct(
                      context,
                      controller: auctionDescreption,
                      title: "Product details",
                      maxLines: 5,
                      validator: (p0) {
                        if (auctionDescreption.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      onTap: () async {
                        if (!_key.currentState!.validate()) {
                        } else {
                          controller.addAuction(
                            name: auctionName.text,
                            price: auctionPrice.text,
                            fee: auctionFee.text,
                            descreption: auctionDescreption.text,
                            dataStart: dataStart,
                            dataEnd: dataEnd,
                            timeStart: timeStart,
                            timeEnd: timeEnd,
                          );
                        }
                      },
                      title: state.loadingForm ? true : "Add".tr(),
                      fontType: FontType.SemiBold,
                      colorButton: secondColor,
                    ),
                    SizedBox(height: heigth * 0.1),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> selectStartDate() async {
    DateTime today = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dataStart,
      firstDate: today,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dataStart = pickedDate;
      setState(() {});
    }
  }

  Future<void> selectEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dataStart,
      firstDate: dataStart,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dataEnd = pickedDate;
      setState(() {});
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: timeStart,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      timeStart = pickedTime;

      if (_isTimeBefore(timeEnd, timeStart)) {
        timeEnd = timeStart;
      }

      setState(() {});
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: timeEnd,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      if (_isTimeBeforeOrEqual(pickedTime, timeStart)) {
        showMessage(
          "The end time must be greater than the start time".tr(),
          value: false,
        );
      } else {
        timeEnd = pickedTime;
        setState(() {});
      }
    }
  }

  bool _isTimeBefore(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour < t2.hour || (t1.hour == t2.hour && t1.minute < t2.minute);
  }

  bool _isTimeBeforeOrEqual(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour < t2.hour || (t1.hour == t2.hour && t1.minute <= t2.minute);
  }
}
