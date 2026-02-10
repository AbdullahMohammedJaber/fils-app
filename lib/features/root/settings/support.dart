// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/support_manage/support_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/defulat_text.dart';

class SupportAndHelpTeam extends StatefulWidget {
  const SupportAndHelpTeam({super.key});

  @override
  State<SupportAndHelpTeam> createState() => _SupportAndHelpTeamState();
}

class _SupportAndHelpTeamState extends State<SupportAndHelpTeam> {
  TextEditingController message = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportCubit, SupportState>(
      listener: (context, state) {
        if(state is SupportSuccess){
          showModalBottomSheet(
                            context: context,
                            elevation: 1,
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              maxHeight: heigth * 0.6,
                            ),
                            isDismissible: true,
                            backgroundColor: white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            builder: (context) {
                              return const SupportMessage();
                            },
                          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heigth * 0.06),
                    ItemTitleBar(
                      title: "Support and help Team".tr(),
                      canBack: true,
                    ),
                    SizedBox(height: heigth * 0.06),
                    DefaultText(
                      "What Problems Are You Facing ?".tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    SizedBox(height: heigth * 0.02),
                    //Translate
                    SizedBox(
                      width: width * 0.8,
                      child: DefaultText(
                        "Welcome To The Help Center. Please Leave Your Message And We Will Get Back To You Within The Next Few Hourse And Responed To You Via Email Or Notifications In The Application."
                            .tr(),
                        type: FontType.regular,
                        overflow: TextOverflow.visible,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: heigth * 0.06),
                    DefaultText(
                      "Your Message".tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    SizedBox(height: heigth * 0.02),
                    TextFormField(
                      maxLines: 7,
                      controller: message,
                      validator: (value) {
                        if (message.text.isEmpty) {
                          return StringApp.requiredField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: textColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: error),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: textColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: textColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: textColor),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: textColor),
                        ),
                      ),
                    ),
                    SizedBox(height: heigth * 0.1),
                    ButtonWidget(
                      colorButton: secondColor,
                      title:state is SupportLoading ? true : "Send".tr(),
                      onTap: () async {
                        if (!_key.currentState!.validate()) {
                        } else {
                          if (!isLogin()) {
                            showDialogAuth(context);
                          } else {
                            await BlocProvider.of<SupportCubit>(context)
                                .supportTicket(message: message.text);

                            
                          }
                        }
                      },
                      fontType: FontType.bold,
                    ),
                    SizedBox(height: heigth * 0.2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SupportMessage extends StatelessWidget {
  const SupportMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/x.svg",
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heigth * 0.02),
            Image.asset("assets/images/done.png"),
            SizedBox(height: heigth * 0.05),
            SizedBox(
              width: width * 0.7,
              child: DefaultText(
                "Your message has been sent to the team. We will respond to you as soon as possible."
                    .tr(),
                color: const Color(0xff5A5555),
                fontSize: 16,
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: heigth * 0.05),
            ButtonWidget(
              title: "back to home Page".tr(),
              colorButton: secondColor,
              sizeTitle: 17,
              fontType: FontType.bold,
              onTap: () {
                Navigator.pop(context);
                ToRemoveAll(AppRoutes.rootGeneral);
              },
            ),
            SizedBox(height: heigth * 0.03),
          ],
        ),
      ),
    );
  }
}
