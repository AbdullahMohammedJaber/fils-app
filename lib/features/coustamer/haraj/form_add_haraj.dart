import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/haraj/haraj_cubit.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/const.dart';
import '../../../utils/string.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/custom_validation.dart';
 import '../../../utils/widget/defualt_text_form_faild.dart';
import '../../../utils/widget/defulat_text.dart';
import '../../../utils/manage_file_widget/manage_file_widget.dart';
import '../search/store/dialog_show_category.dart';

class FormAddHaraj extends StatefulWidget {
  FormAddHaraj({super.key});

  @override
  State<FormAddHaraj> createState() => _FormAddHarajState();
}

class _FormAddHarajState extends State<FormAddHaraj> {
  final _key = GlobalKey<FormState>();

  var nameProductOpenMarket = TextEditingController();

  var priceProductOpenMarket = TextEditingController();

  var locationProductOpenMarket = TextEditingController();

  var descountProductOpenMarket = TextEditingController();

  var quantityProductOpenMarket = TextEditingController();

  var descriptionProductOpenMarket = TextEditingController();

  @override
  void initState() {
    context.read<HarajCubit>().disposeForm(success: false);
    super.initState();
  }

  @override
  void dispose() {
    nameProductOpenMarket.dispose();

    priceProductOpenMarket.dispose();
    locationProductOpenMarket.dispose();
    descountProductOpenMarket.dispose();
    quantityProductOpenMarket.dispose();
    descriptionProductOpenMarket.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<HarajCubit, HarajState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<HarajCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.06, width: width),
                    ItemTitleBar(title: "Add Product".tr(), canBack: true),
                    SizedBox(height: heigth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Product Name".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (nameProductOpenMarket.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: nameProductOpenMarket,
                            textInputType: TextInputType.name,
                            hintText: "Toyota car".tr(),
                            pathIconPrefix: "assets/icons/product_name.svg",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Product price".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (priceProductOpenMarket.text.isEmpty ||
                                priceProductOpenMarket.text == "0") {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: priceProductOpenMarket,
                             isDouble: true,
                      textInputType: TextInputType.phone,
                            hintText:
                                "500 "
                                "KWD",
                            pathIconPrefix: "assets/icons/product_price.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Address".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (locationProductOpenMarket.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: locationProductOpenMarket,
                            textInputType: TextInputType.name,
                            hintText: "Address".tr(),
                            pathIconPrefix: "assets/icons/product_name.svg",
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: heigth * 0.02),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Discount %".tr(),
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
                            controller: descountProductOpenMarket,
                             isDouble: true,
                      textInputType: TextInputType.phone,
                            hintText: "0%",
                            pathIconPrefix: "assets/icons/product_price.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
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
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            hintText: state.nameCategory,
                            pathIconPrefix: "assets/icons/add_cir.svg",
                            isIcon: true,
                            textInputType: TextInputType.none,
                            onTap: () {
                              showCupertinoDialog(
                                context: context,

                                builder:
                                    (context) => DialogShowCategory(
                                      callback: (item) {
                                        controller.functionChangeCategoryData(
                                          item.name,
                                          item.id,
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
                          isLoading:false,
                          height: heigth * 0.2,
                          width: width,
                          label: "product image".tr(),
                          onPickImage: () {
                            controller.functionSelectImage(context);
                          },
                          onRemoveImage: () {
                          controller.removeProductImage();
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
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Product Quantity".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (quantityProductOpenMarket.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: quantityProductOpenMarket,
                            textInputType: TextInputType.number,
                            hintText: "2".tr(),
                            pathIconPrefix: "assets/icons/product_quantity.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/note.svg"),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DefaultText(
                            "The entry must be a number only.".tr(),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Product details".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (descriptionProductOpenMarket.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            maxLine: 5,
                            controller: descriptionProductOpenMarket,
                            textInputType: TextInputType.name,
                            hintText: "".tr(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),

                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      onTap: () {
                        if (!_key.currentState!.validate()) {
                        } else {
                          controller.functionUploadHaraj(
                            context,
                            quantity: quantityProductOpenMarket.text,
                            name: nameProductOpenMarket.text,
                            price: priceProductOpenMarket.text,
                            description: descriptionProductOpenMarket.text,
                            discount: descountProductOpenMarket.text,
                            location: locationProductOpenMarket.text,
                          );
                        }
                      },
                      title:
                          state.loadingAddHaraj
                              ? state.loadingAddHaraj
                              : "Add".tr(),
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
}
