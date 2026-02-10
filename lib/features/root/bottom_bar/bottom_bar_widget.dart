// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/app_manage/app_state.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/storage.dart';
import '../../../utils/widget/dialog_auth.dart';

class CurvedBottomNavigationBar extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final String userType;
  const CurvedBottomNavigationBar({
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
    this.backgroundColor = Colors.white,
    required this.userType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<AppCubit, AppState>(
          builder: (context, state) {
            final controller = context.watch<AppCubit>();
            return SizedBox(
              height: 80,

              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomPaint(
                    size: Size(width, 80),
                    painter: NavBarPainter(
                      selectedIndex: state.selectPageRoot.toDouble(),
                      itemCount:
                          userType == UserType.customer.name
                              ? controller.screenListCoustomer.length
                              : controller.screenListSeller.length,
                      backgroundColor: backgroundColor,
                      textDirection: Directionality.of(context),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        userType == UserType.customer.name
                            ? controller.screenListCoustomer.length
                            : controller.screenListSeller.length,
                        (index) {
                          bool isSelected = index == state.selectPageRoot;
                          final iconPath =
                              userType == UserType.customer.name
                                  ? controller
                                      .screenIconsCoustomer[index]['icons']
                                  : controller
                                      .screenIconsSeller[index]['icons'];
                          final label =
                              userType == UserType.customer.name
                                  ? controller
                                      .screenIconsCoustomer[index]['title']
                                      .toString()
                                      .tr()
                                  : controller.screenIconsSeller[index]['title']
                                      .toString()
                                      .tr();

                          return GestureDetector(
                            onTap: () {
                              if (index == 1) {
                                if (isLogin()) {
                                  controller.onClickBottomNavigationBar(
                                    index,
                                    context
                                        .read<AppCubit>()
                                        .state
                                        .selectPageRoot,
                                  );
                                } else {
                                  showDialogAuth(context);
                                }
                              }
                              if (index == 3) {
                                if (isLogin()) {
                                  controller.onClickBottomNavigationBar(
                                    index,
                                    context
                                        .read<AppCubit>()
                                        .state
                                        .selectPageRoot,
                                  );
                                } else {
                                  showDialogAuth(context);
                                }
                              } else {
                                controller.onClickBottomNavigationBar(
                                  index,
                                  context.read<AppCubit>().state.selectPageRoot,
                                );
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: width * 0.2,
                              height: heigth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: isSelected ? 55 : 40,
                                    width: isSelected ? 55 : 40,
                                    alignment: Alignment.center,
                                    transform:
                                        isSelected
                                            ? Matrix4.translationValues(
                                              0,
                                              -15,
                                              0,
                                            )
                                            : Matrix4.identity(),
                                    decoration:
                                        isSelected
                                            ? BoxDecoration(
                                              color: activeColor,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            )
                                            : null,
                                    child: SvgPicture.asset(
                                      iconPath,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : inactiveColor,
                                      height: isSelected ? 28 : 25,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isSelected ? "" : label.toString().tr(),
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? activeColor
                                              : inactiveColor,
                                      fontSize: 12,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }
}

class NavBarPainter extends CustomPainter {
  final double selectedIndex;
  final int itemCount;
  final Color backgroundColor;
  final TextDirection textDirection; // ← أضف هذا

  NavBarPainter({
    required this.selectedIndex,
    required this.itemCount,
    required this.backgroundColor,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    final path = Path();

    double width = size.width;
    double height = size.height;
    double circleRadius = 35;
    double curveHeight = 50;

    double centerX;

    if (textDirection == TextDirection.rtl) {
      centerX = width - ((selectedIndex + 0.5) * (width / itemCount));
    } else {
      centerX = (selectedIndex + 0.5) * (width / itemCount);
    }

    path.moveTo(0, 0);
    path.lineTo(centerX - circleRadius - 20, 0);

    path.cubicTo(
      centerX - circleRadius,
      0,
      centerX - circleRadius,
      curveHeight,
      centerX,
      curveHeight,
    );

    path.cubicTo(
      centerX + circleRadius,
      curveHeight,
      centerX + circleRadius,
      0,
      centerX + circleRadius + 20,
      0,
    );

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawShadow(path, Colors.black26, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NavBarPainter oldDelegate) => true;
}
