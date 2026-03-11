// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/settings/item_settings.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/theme/theme_cubit.dart';
import 'package:fils/managment/user/user_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:fils/utils/widget/dialog_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

import '../../../managment/theme/theme_state.dart';

class ProfileScreen extends StatefulWidget {
  final String userType;
  ProfileScreen({super.key, required this.userType});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    late final ImageProvider<Object> imageProvider;

    if (isLogin()) {
      if (getUser()!.user!.avatarOriginal.isEmpty) {
        imageProvider = const AssetImage("assets/images/logo_png.png");
      } else {
        imageProvider = NetworkImage(getUser()!.user!.avatarOriginal);
      }
    }
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heigth * 0.06),
                  ItemTitleBar(title: "My Profile".tr(), canBack: false),

                  isLogin()
                      ? SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await context
                                    .read<UserCubit>()
                                    .functionSelectImage(context);
                                setState(() {});
                              },
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                      border: Border.all(
                                        color: textColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),

                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: white,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await context
                                          .read<UserCubit>()
                                          .functionSelectImage(context);
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      radius: 15.5,
                                      backgroundColor: textColor,
                                      child: Icon(Icons.edit, color: white),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: heigth * 0.025),
                            DefaultText(
                              getUser()!.user!.name,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            DefaultText(
                              getUser()!.user!.email,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                            if (getUser()!.user!.type == "seller")
                              IconButton(
                                onPressed: () {
                                  shareStoreLink(context ,
                                    getMyShopsDetails().id.toString(),
                                  );
                                },

                                icon: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: textColor,
                                ),
                              ),
                          ],
                        ),
                      )
                      : const SizedBox(),

                  SizedBox(height: heigth * 0.02),
                  BlocConsumer<ThemeCubit, ThemeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        children: [
                          Switch(
                            value: getTheme(),
                            onChanged: (value) {
                              context.read<ThemeCubit>().toggleTheme(value);
                            },
                          ),

                          const SizedBox(width: 10),
                          DefaultText(
                            "Theme".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ],
                      );
                    },
                  ),
                  BlocConsumer<ThemeCubit, ThemeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Row(
                        children: [
                          Switch(
                            value: isShowNotification(),
                            onChanged: (value) {
                              context.read<ThemeCubit>().toggleNotification(
                                value,
                              );
                            },
                          ),

                          const SizedBox(width: 10),
                          DefaultText(
                            "Notifications".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ],
                      );
                    },
                  ),
                  if (!isLogin() || getUser()!.user!.type == UserType.customer.name)
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                        itemSetting(
                          pathIcon: "assets/icons/my_order.svg",
                          title: "My Orders".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.orderC);
                            }
                          },
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),

                        itemSetting(
                          pathIcon: "assets/icons/favourite_home.svg",
                          title: "Favourite".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.favorites);
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                        itemSetting(
                          pathIcon: "assets/icons/setting.svg",
                          title: "Settings".tr(),
                          onClick: () {
                            ToWithFade(AppRoutes.settingsScreen);
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                        itemSetting(
                          pathIcon: "assets/icons/notification_home.svg",
                          title: "Notifications".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.notificationScreen);
                            }
                          },
                        ),

                        isLogin()
                            ? Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: width * 0.02,
                              ),
                              child: Divider(thickness: 0.5, color: textColor),
                            )
                            : const SizedBox(),

                        isLogin()
                            ? itemSetting(
                              pathIcon: "assets/icons/switch_seller.svg",
                              title: "Switch to seller account".tr(),
                              onClick: () async {
                                if (isLogin()) {
                                  context.read<AuthCubit>().switchAccountUser(
                                    context,
                                    userType: 'seller',
                                  );
                                } else {
                                  showDialogAuth(context);
                                }
                              },
                            )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),

                        itemSetting(
                          pathIcon: "assets/icons/support.svg",
                          title: "Support and help Team".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.supportAndHelpTeam);
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                        itemSetting(
                          pathIcon: "assets/icons/setting.svg",
                          title: "Settings".tr(),
                          onClick: () {
                            ToWithFade(AppRoutes.settingsScreen);
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                        itemSetting(
                          pathIcon: "assets/icons/notification_home.svg",
                          title: "Notifications".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.notificationScreen);
                            }
                          },
                        ),

                        isLogin()
                            ? Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: width * 0.02,
                              ),
                              child: Divider(thickness: 0.5, color: textColor),
                            )
                            : const SizedBox(),

                        isLogin()
                            ? itemSetting(
                              pathIcon: "assets/icons/switch_seller.svg",
                              title: "Switch to customer account".tr(),
                              onClick: () async {
                                if (isLogin()) {
                                  context.read<AuthCubit>().switchAccountUser(
                                    context,
                                    userType: UserType.customer.name,
                                  );
                                } else {
                                  showDialogAuth(context);
                                }
                              },
                            )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),

                        itemSetting(
                          pathIcon: "assets/icons/support.svg",
                          title: "Support and help Team".tr(),
                          onClick: () {
                            if (!isLogin()) {
                              showDialogAuth(context);
                            } else {
                              ToWithFade(AppRoutes.supportAndHelpTeam);
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: Divider(thickness: 0.5, color: textColor),
                        ),
                      ],
                    ),
                  !isLogin()
                      ? itemSetting(
                        pathIcon: "assets/icons/logout.svg",
                        title: "Login".tr(),
                        onClick: () {
                          To(AppRoutes.login);
                        },
                      )
                      : SizedBox(),
                  isLogin()
                      ? GestureDetector(
                        onTap: () {
                          showDialogLogout(context);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: width,
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(
                                    0xffE4626F,
                                  ).withOpacity(0.5),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/logout.svg",
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              DefaultText(
                                "Logout".tr(),
                                fontSize: 14,
                                color: const Color(0xffE4626F),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: width * 0.02),
                            ],
                          ),
                        ),
                      )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: width * 0.02),
                    child: Divider(thickness: 0.5, color: textColor),
                  ),
                  isLogin()
                      ? GestureDetector(
                        onTap: () {
                          showDialogDelete(context);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: width,
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(
                                    0xffE4626F,
                                  ).withOpacity(0.5),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/delete.svg",
                                    height: 25,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              DefaultText(
                                "Delete Account".tr(),
                                fontSize: 14,
                                color: const Color(0xffE4626F),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: width * 0.02),
                            ],
                          ),
                        ),
                      )
                      : const SizedBox(),
                  SizedBox(height: heigth * 0.1),
                  SizedBox(height: heigth * 0.02),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
