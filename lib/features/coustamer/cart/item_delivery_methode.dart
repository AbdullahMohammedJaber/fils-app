import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/address/address_widget.dart';
import 'package:fils/managment/cart/cart_cubit.dart';

import 'package:fils/utils/global_function/validation.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/animation/custom_fade_animation.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

import '../../../utils/widget/defulat_text.dart';
 
class ItemDeliveryMethod extends StatelessWidget {
  const ItemDeliveryMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<CartCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: width,
                  margin: EdgeInsets.only(top: heigth * 0.01),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CustomFadeAnimationComponent(
                    1,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: controller.key,
                        child: Column(
                          children: [
                            SizedBox(height: heigth * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: DeliveryTextField(
                                    controller: controller.nameController ,
                                    hint: "Full Name".tr(),
                                    validator: (p0) {
                                      if (p0 == null || p0.isEmpty) {
                                        return StringApp.requiredField.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DeliveryTextField(
                                    controller: controller.phoneController ,
                                    hint: "Mobile Number".tr(),
                                    keyboard: TextInputType.phone,
                                    validator: (p0) {
                                      if (p0 == null || p0.isEmpty) {
                                        return StringApp.requiredField.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heigth * 0.01),
                            DeliveryTextField(
                              controller: controller.emailController ,
                              hint: "E - mail".tr(),
                              keyboard: TextInputType.emailAddress,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return StringApp.requiredField.tr();
                                } else if (!isEmailValid(p0)) {
                                  return StringApp.emailFalse;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: heigth * 0.01),
                            DeliveryTextField(
                              controller: controller.addressController ,
                              hint: "Address".tr(),
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return StringApp.requiredField.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: heigth * 0.01),
                            AreaFieldWidget(
                              controller: controller.areaController ,
                              onSelect: (selectedAddress) {
                                controller.areaController .text =
                                    selectedAddress['name'];
                                controller.selectItemAddress(
                                  selectedAddress['id'],
                                  selectedAddress['name'],
                                );
                              },
                            ),
                  
                            SizedBox(height: heigth * 0.02),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/note.svg"),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  child: DefaultText(
                                    "Enter your accommodation details to list the best delivery companies for you"
                                        .tr(),
                                    overflow: TextOverflow.visible,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeliveryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;

  const DeliveryTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboard = TextInputType.text,
    this.validator,
    this.suffix,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class AreaFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<dynamic> onSelect;

  const AreaFieldWidget({
    super.key,
    required this.controller,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return DeliveryTextField(
      controller: controller,
      hint: "Area".tr(),
      readOnly: true,
      validator: (p0) {
        if (p0 == null || p0.isEmpty) {
          return StringApp.requiredField.tr();
        }
        return null;
      },
      suffix: const Icon(Icons.arrow_drop_down),
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder:
              (_) => AddressWidget(
                callback: (item) {
                  onSelect(item);
                },
              ),
        );
      },
    );
  }
}
