import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/user/user_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/const.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import '../../chat_bot/chat_bot.dart';

class AppBarHomeSeller extends StatelessWidget {
  const AppBarHomeSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    late final ImageProvider<Object> imageProvider;

                    if (isLogin()) {
                      if (getUser()!.user!.avatarOriginal.isEmpty) {
                        imageProvider = const AssetImage(
                          "assets/images/logo_png.png",
                        );
                      } else {
                        imageProvider = NetworkImage(
                          getUser()!.user!.avatarOriginal,
                        );
                      }
                    }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*ToWithFade(
                              context,
                              ImageView(
                                images: [user.user!.user!.avatarOriginal],
                                initialIndex: 0,
                              ),
                            );*/
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: imageProvider,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultText(
                                state.greeting.tr(),
                                color: textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              DefaultText(
                                getUser()!.user!.name,
                                color: grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints(
                          minHeight: heigth * 0.9,
                          minWidth: width,
                        ),
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        showDragHandle: true,
                        isScrollControlled: true,
                        useSafeArea: true,
                        enableDrag: true,
                        builder: (context) => const ChatBot(),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: grey6,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/boot.svg",
                          color: Colors.black,
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  GestureDetector(
                    onTap: () {
                      ToWithFade(AppRoutes.notificationScreen);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: grey6,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/notification_home.svg",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                ],
              ),
            ],
          ),
          getUser()!.user!.can_switch_between_accounts
              ? Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      context.read<AuthCubit>().switchAccountUser(
                        context,
                        userType: "customer",
                      );
                    },
                    icon: const Icon(Icons.swap_horiz),
                  ),
                  DefaultText("Switch to Customer".tr()),
                ],
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
