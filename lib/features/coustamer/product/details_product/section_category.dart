// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/string.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/data/response/product/details_product_response.dart';
import '../../../../utils/const.dart';
import '../../../../utils/theme/color_manager.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../../utils/widget/custom_validation.dart';
import '../../../../utils/widget/defualt_text_form_faild.dart';
import '../../../../utils/widget/defulat_text.dart';


class SectionCategory extends StatefulWidget {
  final ProductData details;

  const SectionCategory({super.key, required this.details});

  @override
  State<SectionCategory> createState() => _SectionCategoryState();
}

class _SectionCategoryState extends State<SectionCategory> {
  double value = 1;
  TextEditingController rateController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          DefaultText(
            widget.details.shopName,
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          const Spacer(),
          Row(
            children: [
              SvgPicture.asset("assets/icons/rate.svg", height: 25),
              SizedBox(width: width * 0.01),
              GestureDetector(
                onTap: () async {
                  _showBottomSheet();
                },
                child: DefaultText(
                    "Write Rate".tr(),
                  color: textColor,
                  fontSize: 12,
                  textDecoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _key,
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: heigth * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: RatingStars(
                          value: value,
                          onValueChanged: (v) {
                            setState(() {
                              value = v;
                            });
                          },
                          starBuilder:
                              (index, color) => Icon(Icons.star, color: color),
                          starCount: 5,
                          starSize: 20,
                          valueLabelRadius: 10,
                          maxValue: 5,
                          starSpacing: 2,
                          maxValueVisibility: true,
                          valueLabelVisibility: true,
                          animationDuration: const Duration(milliseconds: 1000),
                          valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 8,
                          ),
                          valueLabelMargin: const EdgeInsets.only(right: 8),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Colors.amber,
                        ),
                      ),
                    ),
                    SizedBox(height: heigth * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ValidateWidget(
                        validator: (key) {
                          if (rateController.text.isEmpty) {
                            return StringApp.requiredField.tr();
                          } else {
                            return null;
                          }
                        },
                        child: TextFormFieldWidget(
                          controller: rateController,
                          textInputType: TextInputType.name,
                          hintText: "Write Rate".tr(),
                        ),
                      ),
                    ),
                    SizedBox(height: heigth * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ButtonWidget(
                        onTap: () async {
                          if (!_key.currentState!.validate()) {
                          } else {
                           /* showBoatToast();
                            var json = await NetworkHelper.sendRequest(
                              requestType: RequestType.post,
                              endpoint: "reviews/submit",
                              fields: {
                                "product_id": widget.details.id,
                                "user_id": getUser()!.user!.id,
                                "rating": value,
                                "comment": rateController.text,
                              },
                            );
                            closeAllLoading();
                            Navigator.pop(context);
                            BaseResponse baseResponse = BaseResponse.fromJson(
                              json,
                            );
                            rateController.clear();
                            value = 1;
                            showCustomFlash(
                              message: baseResponse.message,
                              messageType:
                                  baseResponse.result!
                                      ? MessageType.Success
                                      : MessageType.Faild,
                            );*/
                          }
                        },
                        title: "Send".tr(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
