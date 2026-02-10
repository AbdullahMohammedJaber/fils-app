import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/seller/subsecribe/item_subscripe.dart';
import 'package:fils/managment/subscriptions/subscriptions_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/const.dart';
import '../../../utils/storage.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import '../../../utils/widget/flip_view.dart';

class SubscriptionsScreen extends StatefulWidget { 
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionsCubit>().getSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: heigth * 0.05, width: width),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: getLang() == 'ar' ? 30 : 28,
                    width: 40,
                    child: FlipView(
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/back.svg",
                          color: getTheme() ? white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: width * 0.01),
                DefaultText(
                  "Subscriptions".tr(),
                  color: primaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: heigth * 0.01, width: width),
            Row( 
              children: [
                DefaultText(
                  "Let's choose your subscription plan".tr(),
                  color: textColor,
                  overflow: TextOverflow.visible,
                  fontSize: 14,

                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: heigth * 0.03, width: width),

            SizedBox(
              width: width * 0.8,
              child: DefaultText(
                "Complete the subscription process before continuing. This step helps to protect your account and prevent spam."
                    .tr(),
                color: const Color(0xff5A5555),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                fontSize: 14,

                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: heigth * 0.05, width: width),

            Expanded(
              child: BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                builder: (context, state) {
                  if (state.loading) {
                    return LoadingUi();
                  } else if (state.error != null) {
                    return NeonNoInternetView(
                      onRetry: () {},
                      error: state.error!,
                    );
                  } else {
                    if (state.subscribe != null) {
                      if (state.subscribe!.isEmpty) {
                        return NeonNoInternetView(
                          onRetry: () {},
                          error: StringApp.noData,
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return ItemSubscribe(
                              subscribe: state.subscribe![index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: state.subscribe!.length,
                        );
                      }
                    } else {
                      return SizedBox();
                    }
                  }
                },
              ),
            ),
            Container(
              height: heigth * 0.08,
              margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffE8E2F8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/cup.svg"),
                      const SizedBox(width: 10),
                      DefaultText(
                        "Quality & Security Guarantee".tr(),
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DefaultText(
                    "All subscriptions are protected and 100% guaranteed".tr(),
                    color: textColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
