import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/search/store/dialog_show_category.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/widget_form.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/manage_file_widget/manage_file_widget.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/const.dart';

class FormAddProduct extends StatefulWidget {
  const FormAddProduct({super.key});

  @override
  State<FormAddProduct> createState() => _FormAddProductState();
}

class _FormAddProductState extends State<FormAddProduct> {
  final _key = GlobalKey<FormState>();

  TextEditingController nameProduct = TextEditingController();
  TextEditingController priceProduct = TextEditingController();
  TextEditingController quantityProduct = TextEditingController();
  TextEditingController descriptionProduct = TextEditingController();
  TextEditingController discountProduct = TextEditingController();
  @override
  void initState() {
    context.read<ProductSellerCubit>().clearForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<ProductSellerCubit, ProductSellerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<ProductSellerCubit>();
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.05, width: width),
                    ItemTitleBar(title: "Add Product".tr(), canBack: true),
                    SizedBox(height: heigth * 0.08),
                    faildFormProduct(
                      context,
                      controller: nameProduct,
                      textInputType: TextInputType.name,
                      title: "Product Name",
                      pathIcon: "assets/icons/product_name.svg",
                      validator: (p0) {
                        if (nameProduct.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      controller: priceProduct,
                      textInputType: TextInputType.number,
                      isDouble: true,
                      title: "Product price",
                      pathIcon: "assets/icons/product_price.svg",
                      validator: (p0) {
                        if (priceProduct.text.isEmpty ||
                            priceProduct.text == "0") {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      controller: discountProduct,
                      textInputType: TextInputType.number,
                      isDouble: true,
                      title: "Discount %",
                      pathIcon: "assets/icons/product_price.svg",
                      validator: (p0) {
                        return null;
                      },
                    ),

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
                            }
                            return null;
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            pathIconPrefix: "assets/icons/add_cir.svg",
                            isIcon: true,
                            controller: TextEditingController(
                              text: state.nameCategory ?? "",
                            ),
                            textInputType: TextInputType.none,
                            onTap: () {
                              showCupertinoDialog(
                                context: context,

                                builder:
                                    (context) => DialogShowCategory(
                                      callback: (item) {
                                        controller.functionChangeCategoryData(
                                          item.name!,
                                          item.id!,
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
                    state.idCategory != null
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: heigth * 0.02),

                            DefaultText(
                              "Sub Category".tr(),
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            SizedBox(width: width, height: heigth * 0.01),
                            ValidateWidget(
                              validator: (value) {
                                if (state.categoryIds.isEmpty) {
                                  return StringApp.requiredField;
                                }
                                return null;
                              },
                              child: TextFormFieldWidget(
                                isPreffix: true,
                                pathIconPrefix: "assets/icons/add_cir.svg",
                                isIcon: true,
                                controller: TextEditingController(
                                  text: state.nameCategores ?? "",
                                ),
                                textInputType: TextInputType.none,
                                onTap: () {
                                  showCupertinoDialog(
                                    context: context,

                                    builder:
                                        (context) => DialogShowMultiCategory(
                                          categoryId: state.idCategory!,
                                          callback: (item) {
                                            controller
                                                .functionChangeCategoryListData(
                                                  item,
                                                );
                                          },
                                        ),
                                  );
                                },
                                pathIcon: "assets/icons/drob.svg",
                              ),
                            ),
                          ],
                        )
                        : SizedBox(),
                    SizedBox(height: heigth * 0.02),

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
                          isLoading: false,
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

                    faildFormProduct(
                      context,
                      controller: quantityProduct,
                      textInputType: TextInputType.number,
                      title: "Product Quantity",
                      pathIcon: "assets/icons/product_quantity.svg",
                      validator: (p0) {
                        if (quantityProduct.text.isEmpty ||
                            quantityProduct.text == "0") {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),

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
                          "Options".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            onTap: () {
                              ToWithFade(AppRoutes.optionScreen);
                            },
                            hintText: state.hintOption.tr(),
                            pathIconPrefix: "assets/icons/add_cir.svg",
                            isIcon: true,
                            pathIcon: "assets/icons/goo.svg",
                          ),
                        ),
                      ],
                    ),
                    faildFormProduct(
                      context,
                      controller: descriptionProduct,
                      maxLines: 5,
                      title: "Product details",

                      validator: (p0) {
                        if (descriptionProduct.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      onTap: () {
                        if (!_key.currentState!.validate()) {
                        } else {
                          controller.addProduct(
                            context,
                            name: nameProduct.text,

                            description: descriptionProduct.text,
                            price: priceProduct.text,
                            discount: discountProduct.text,
                            quantity: quantityProduct.text,
                          );
                        }
                      },
                      title: state.loading ? true : "Add".tr(),
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
