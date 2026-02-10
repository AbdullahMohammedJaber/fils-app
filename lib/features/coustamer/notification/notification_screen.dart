import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/notification/notification_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/const.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import '../cart/slidable_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: heigth * 0.03),
            ItemTitleBar(title: "Notifications".tr(), canBack: true),
            SizedBox(height: heigth * 0.03),
            Expanded(
              child: BlocProvider<NotificationCubit>(
                create: (context) {
                  return NotificationCubit()..getAllNotification(refresh: true);
                },
                child: BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationLoading) {
                      return LoadingUi();
                    } else if (state is NotificationLoadingError) {
                      return NeonNoInternetView(
                        onRetry: () {
                          context.read<NotificationCubit>().getAllNotification(
                            refresh: true,
                          );
                        },
                        error: state.error!,
                      );
                    } else if (state is NotificationLoaded) {
                      final notifications = state.notifications;
                      if (notifications.isEmpty) {
                        return EmptyDataScreen(
                          
                        );
                      } else {
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scroll) {
                            if (scroll.metrics.pixels >=
                                    scroll.metrics.maxScrollExtent - 200 &&
                                state.hasMore) {
                              context
                                  .read<NotificationCubit>()
                                  .getAllNotification();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index == notifications.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(child: LoadingUi()),
                                );
                              }
                              return Slidable(
                                direction: Axis.horizontal,
                                enabled: true,
                                closeOnScroll: true,
                                key: ValueKey(notifications[index].id),
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    Expanded(
                                      child: CustomSlideAction(
                                        color: const Color(0xffF1673C),
                                        imagePath: "assets/icons/delete.svg",
                                        onTap: () async {},
                                      ),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: 80,
                                  width: width,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xff898384),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE8E2F8),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Center(
                                            child:
                                                notifications[index].image ==
                                                        null
                                                    ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      child: Image.asset(
                                                        "assets/images/fils_logo_f.png",
                                                      ),
                                                    )
                                                    : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                      child: Image.network(
                                                        notifications[index]
                                                            .image!,
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.02),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DefaultText(
                                                notifications[index]
                                                    .notificationText,
                                                color: textColor,
                                                overflow: TextOverflow.visible,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              SizedBox(height: heigth * 0.01),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/calendar.svg",
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.01,
                                                      ),
                                                      DefaultText(
                                                        notifications[index]
                                                            .date,
                                                        color: textColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: width * 0.05),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },

                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                state.hasMore
                                    ? notifications.length + 1
                                    : notifications.length,
                          ),
                        );
                      }
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
