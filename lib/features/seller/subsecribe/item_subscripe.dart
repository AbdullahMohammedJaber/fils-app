// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/subscriptions/subscriptions_response.dart';
import 'package:fils/managment/subscriptions/subscriptions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

 import '../../../utils/global_function/validation.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemSubscribe extends StatefulWidget {
  Subscribe subscribe;

  ItemSubscribe({super.key, required this.subscribe});

  @override
  State<ItemSubscribe> createState() => _ItemSubscribeState();
}

class _ItemSubscribeState extends State<ItemSubscribe> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.subscribe.isSelect = !widget.subscribe.isSelect;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffE8E2F8)),
            ),
            child: Column(
              children: [
                //TODO TITLE
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: hexToColor(widget.subscribe.color!),
                        ),
                        child: Center(
                          child:
                              widget.subscribe.logo != null
                                  ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                      widget.subscribe.logo!,
                                    ),
                                  )
                                  : SvgPicture.asset(
                                    "assets/icons/favourite_home.svg",
                                  ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            widget.subscribe.name!,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            widget.subscribe.price!.toDouble().toStringAsFixed(
                              2,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 3),
                          DefaultText(
                            "KWD",
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                            color: error,
                          ),
                          const SizedBox(height: 3),
                          DefaultText(
                            containsPlatinum(widget.subscribe.name!)
                                ? "Yearly".tr()
                                : "Monthly".tr(),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: SvgPicture.asset("assets/icons/drob.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
                //TODO Content
                widget.subscribe.isSelect
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(color: textColor),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                "* Features : ".tr(),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              const SizedBox(height: 20),
                              ...List.generate(
                                widget.subscribe.featuers!.length,
                                (index) => Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        // ignore: deprecated_member_use
                                        color: purpleColor.withOpacity(0.5),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/check.svg",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    DefaultText(
                                      widget.subscribe.featuers![index],
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              ...List.generate(
                                widget.subscribe.extraFeatures!.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: DefaultText(
                                    "🔹 ${widget.subscribe.extraFeatures![index]}",
                                    overflow: TextOverflow.visible,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: ButtonWidget(
                            onTap: () async {
                              context.read<SubscriptionsCubit>().paySubscribe(
                                widget.subscribe.id.toString(),
                                
                              );
                            },
                            title:
                                state.loadingSubscribe
                                    ? true
                                    : "Subscribe".tr(),
                            colorButton: primaryColor,
                          ),
                        ),
                      ],
                    )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
