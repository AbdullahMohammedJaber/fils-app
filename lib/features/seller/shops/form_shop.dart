import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/widget_form.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/manage_file_widget/manage_file_widget.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FormShop extends StatefulWidget {
  const FormShop({super.key});

  @override
  State<FormShop> createState() => _FormShopState();
}

class _FormShopState extends State<FormShop> {
  final _key = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopIdNController = TextEditingController();
  TextEditingController shopLiscnicNController = TextEditingController();
  @override
  void initState() {
  
    super.initState();
    context.read<ShopsCubit>().clearAttachment();
  }
  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<ShopsCubit>();
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heigth * 0.06, width: width),
                    ItemTitleBar(title: "Add about store".tr(), canBack: true),
                    SizedBox(height: heigth * 0.03),
                    DefaultText(
                      "Store Add".tr(),
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: heigth * 0.02),
                    faildFormProduct(
                      context,
                      controller: shopNameController,
                      title: "Online store name",
                      pathIcon: "assets/icons/store.svg",
                      validator: (p0) {
                        if (shopNameController.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      controller: shopAddressController,
                      title: "Address",
                      pathIcon: "assets/icons/address.svg",
                       validator: (p0) {
                        if (shopAddressController.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    faildFormProduct(
                      context,
                      controller: shopDescController,
                      title: "description",
                      maxLines: 3,
                       validator: (p0) {
                        if (shopDescController.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
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
                          image: state.shopImage,
                          isLoading: false,
                          height: heigth * 0.2,
                          width: width,
                          label: "product image".tr(),
                          onPickImage: () {
                            controller.functionSelectImage(context);
                          },
                          onRemoveImage: () {
                            controller.clearFormShop();
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
                      controller: shopIdNController,
                      title: "ID or passport number",
                       validator: (p0) {
                        if (shopIdNController.text.isEmpty) {
                          return StringApp.requiredField;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: heigth * 0.01),
                    DefaultText(
                      "This section is for licensed owners. If you do not have a license for your store, you can skip this section and complete the registration."
                          .tr(),
                      overflow: TextOverflow.visible,
                      fontSize: 12,
                      color: error,
                    ),
                    SizedBox(height: heigth * 0.03),

                    faildFormProduct(
                      context,

                      controller: shopLiscnicNController,
                      title: "License Number",
                    ),
                    SizedBox(height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Upload License Image".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        if(state.shopLinciseImage!=null)
                         Row(
                           children: [
                             DefaultText("Done Upload License".tr() , color: Colors.green,),
                             IconButton(onPressed: () {
                                controller.selectAndUploadFileC();
                             }, icon: Icon(Icons.edit)),
                            ],
                         )
                         else
                        ValidateWidget(
                          validator: (value) {
                            return null;
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            onTap: () {
                              controller.selectAndUploadFileC();
                            },
                            hintText: "License Image".tr(),
                            pathIconPrefix: "assets/icons/product_image.svg",
                            customIcon: Container(
                              width: width * 0.1,
                              height: heigth * 0.06,
                              decoration: BoxDecoration(
                                color: greyLight,
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(12),
                                      topEnd: Radius.circular(12),
                                    ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/gellary_black.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      onTap: () {
                        if (!_key.currentState!.validate()) {
                        } else {
                          controller.createShop(
                            data: {
                              "name": shopNameController.text,
                              "description": shopDescController.text,
                              "address": shopAddressController.text,
                              "id_number": shopIdNController.text,
                              if (shopLiscnicNController.text.isNotEmpty)
                                "license_no": shopLiscnicNController.text,

                              "logo": state.shopImageId,
                              "owner_name": getUser()!.user!.name,
                            },
                          );
                        }
                      },
                      title: state.isLoading ? true : "Send".tr(),
                    ),
                    SizedBox(height: heigth * 0.05),
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
