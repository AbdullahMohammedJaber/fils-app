import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/seller/product/header_details_seller.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class DetailsProductSellerScreen extends StatefulWidget {
  final int idProduct;
  const DetailsProductSellerScreen({super.key, required this.idProduct});

  @override
  State<DetailsProductSellerScreen> createState() => _DetailsProductSellerScreenState();
}

class _DetailsProductSellerScreenState extends State<DetailsProductSellerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductSellerCubit>().getDetailsProduct(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSellerCubit, ProductSellerState>(
      builder: (context, state) {
        if (state.loadingGetDetailsProduct) {
          return LoadingUi();
        } else if (state.errorDetails != null) {
          return NeonNoInternetView(
            onRetry: () {
              context.read<ProductSellerCubit>().getDetailsProduct(
                widget.idProduct,
              );
            },
            error: state.errorDetails!,
          );
        } else if (state.detailsProductSellerResponse != null) {
          var controller = state.detailsProductSellerResponse!.data;
          return Scaffold(
            appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  HeaderDetailsSellerProduct(details: controller),
                  SizedBox(height: heigth * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        DefaultText(
                          controller.shopName,
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const Spacer(),
                        DefaultText(
                          "${controller.unitPrice} KWD",
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: secondColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DefaultText(
                      controller.productName,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  controller.variantProduct == 0
                      ? const SizedBox()
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                DefaultText(
                                  "Option2".tr(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: width * 0.02),
                                DefaultText(
                                  "View option guide".tr(),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: textColor,
                                ),
                              ],
                            ),
                            SizedBox(height: heigth * 0.02),
                            Row(
                              children: [
                                for (
                                  dynamic i = 0;
                                  i < controller.colors.length;
                                  i++
                                )
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(color: grey4),
                                      color: Color(
                                        int.parse(
                                          controller.colors[i].replaceAll(
                                            '#',
                                            '0xff',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: heigth * 0.02),
                            Row(
                              children: [
                                for (
                                  dynamic i = 0;
                                  i < controller.stocks.data.length;
                                  i++
                                )
                                  Container(
                                    height: 40,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryColor),
                                    ),
                                    child: Center(
                                      child: DefaultText(
                                        controller.stocks.data[i].variant,
                                        color: blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  SizedBox(height: heigth * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              "Quantity".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: heigth * 0.01),
                            Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: textColor),
                              ),
                              child: Center(
                                child: DefaultText(
                                  controller.currentStock.toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: width * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              "Number of reviews".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: heigth * 0.01),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: textColor),
                                  ),
                                  child: Center(
                                    child: DefaultText(
                                      controller.reviews_count.toString(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.03),
                                DefaultText(
                                  "(4.8)".tr(),
                                  textDecoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                SizedBox(width: width * 0.01),
                                SvgPicture.asset("assets/icons/star.svg"),
                                SizedBox(width: width * 0.02),
                                GestureDetector(
                                  onTap: () async {},
                                  child: DefaultText(
                                    "View users".tr(),
                                    textDecoration: TextDecoration.underline,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              "Number of additions to favorites".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: heigth * 0.01),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: textColor),
                                  ),
                                  child: Center(
                                    child: DefaultText(
                                      controller.fav_count.toString(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.03),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Product Details".tr(),
                          fontSize: 14,
                          color: const Color(0xff5A5555),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: heigth * 0.01),
                        controller.description != null
                            ? SizedBox(
                              width: width,
                              child: Html(data: controller.description),
                            )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async{
                          context.read<ProductSellerCubit>().deleteProduct(controller.id);
                          },
                          child:state.loading? LoadingUi( ): SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/delete_red.svg",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                        Expanded(
                          child: ButtonWidget(
                            onTap: () {
                              ToRemove(AppRoutes.editProductScreen,  arguments: state.detailsProductSellerResponse!.data);
                            },
                            title: "Edit".tr(),
                            colorButton: secondColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.05),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
