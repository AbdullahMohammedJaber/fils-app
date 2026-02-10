import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';
import 'package:fils/features/coustamer/search/store/dialog_show_category.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/widget_form.dart';
import 'package:fils/managment/product/seller/edit_product_cubit.dart';
import 'package:fils/utils/const.dart';
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

class EditProductScreen extends StatefulWidget {
  final DetailsProductSeller detailsProductSellerResponse;
  const EditProductScreen({
    super.key,
    required this.detailsProductSellerResponse,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController nameProduct = TextEditingController();
  TextEditingController priceProduct = TextEditingController();
  TextEditingController descreptionProduct = TextEditingController();
  TextEditingController quantityProduct = TextEditingController();
  TextEditingController discountProduct = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fillDataForm();
  }

  _fillDataForm() {
    nameProduct.text = widget.detailsProductSellerResponse.productName;
    priceProduct.text =
        widget.detailsProductSellerResponse.unitPrice.toString();
    descreptionProduct.text = widget.detailsProductSellerResponse.description;
    quantityProduct.text =
        widget.detailsProductSellerResponse.currentStock.toString();
    discountProduct.text =
        widget.detailsProductSellerResponse.discount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProductCubit>(
      create:
          (context) =>
              EditProductCubit()
                ..fillForm(context, widget.detailsProductSellerResponse),
      child: BlocConsumer<EditProductCubit, EditProductState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(toolbarHeight: 0),
            body: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(height: heigth * 0.05, width: width),
                      ItemTitleBar(title: "Edit Product".tr(), canBack: true),
                      SizedBox(height: heigth * 0.08),
                      faildFormProduct(
                        context,
                        controller: nameProduct,
                        title: "Product Name",
                        pathIcon: "assets/icons/product_name.svg",
                      ),
                      faildFormProduct(
                        context,
                        controller: priceProduct,
                        title: "Product price",
                        pathIcon: "assets/icons/product_price.svg",
                      ),
                      faildFormProduct(
                        context,
                        controller: discountProduct,
                        title: "Discount %",
                        pathIcon: "assets/icons/product_price.svg",
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
                                          context
                                              .read<EditProductCubit>()
                                              .functionChangeCategoryData(
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
                                  if (state.categoryIds == null) {
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
                                              context
                                                  .read<EditProductCubit>()
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
                            urlImage: state.urlImage,
                            isLoading: false,
                            height: heigth * 0.2,
                            width: width,
                            label: "product image".tr(),
                            onPickImage: () {
                              context
                                  .read<EditProductCubit>()
                                  .functionSelectImage(context);
                            },
                            onRemoveImage: () {
                              context
                                  .read<EditProductCubit>()
                                  .clearAttachment();
                            },
                            validator: (file) {
                              if (file == null && state.idImage==null && state.urlImage==null) {
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
                        title: "Product Quantity",
                        pathIcon: "assets/icons/product_quantity.svg",
                      ),
                      faildFormProduct(
                        context,
                        controller: descreptionProduct,
                        title: "Product details",
                        maxLines: 5,
                      ),
                      SizedBox(height: heigth * 0.03),
                      ButtonWidget(
                        onTap: () {
                          if (!_key.currentState!.validate()) {
                          } else {
                            context.read<EditProductCubit>().editProduct(
                              context,
                              widget.detailsProductSellerResponse.id,
                              name: nameProduct.text,
                              description: descreptionProduct.text,
                              price: priceProduct.text,
                              discount: discountProduct.text,
                              quantity: quantityProduct.text,
                            );
                          }
                        },
                        title:state.loading ? true :  "Edit".tr(),
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
        listener: (context, state) {},
      ),
    );
  }
}
