import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/product/details_product/section_category.dart';
import 'package:fils/features/coustamer/product/details_product/section_count_add_cart.dart';
import 'package:fils/managment/detail_product/details_product_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/const.dart';
import '../../../../utils/theme/color_manager.dart';
import '../../../../utils/widget/defulat_text.dart';
import 'header_details_product.dart';
import 'option_section.dart';

class DetailsProductRoot extends StatelessWidget {
  final int id;

  const DetailsProductRoot({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
      body: BlocProvider<DetailsProductCubit>(
        create: (context) => DetailsProductCubit()..getDetailsProduct(id),
        child: BlocBuilder<DetailsProductCubit, DetailsProductState>(
          builder: (context, state) {
            var controller = context.read<DetailsProductCubit>();
            if (state.loadingDetails) {
              return LoadingUi();
            } else if (state.error != null) {
              return NeonNoInternetView(
                onRetry: () {
                  context.read<DetailsProductCubit>().getDetailsProduct(id);
                },
                error: state.error!,
              );
            } else if (state.detailsProductResponse != null) {
              var data = state.detailsProductResponse!.data.product.data;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.photos!.data.isNotEmpty ||
                            data.thumbnailImg!.data.isNotEmpty
                        ? HeaderDetailsProduct(details: data)
                        : const SizedBox(),
                    SizedBox(height: heigth * 0.01),

                    SectionCategory(details: data),
                    SizedBox(height: heigth * 0.003),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DefaultText(
                        data.productName,
                        color: blackColor,
                        fontSize: 16,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: heigth * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DefaultText(
                        "${data.price_after_discount}",
                        color: secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    data.colors!.isNotEmpty || data.choiceOptions!.isNotEmpty
                        ? OptionSection(details: data)
                        : const SizedBox(),
                    SizedBox(height: heigth * 0.03),
                    SectionCountAddCart(details: data),
                    SizedBox(height: heigth * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.description == null
                              ? const SizedBox()
                              : DefaultText(
                                "Product Details".tr(),
                                fontSize: 14,
                                color: const Color(0xff5A5555),
                                fontWeight: FontWeight.w500,
                              ),
                          SizedBox(height: heigth * 0.01),
                          data.description == null
                              ? const SizedBox()
                              : SizedBox(
                                width: width * 0.85,
                                child: Html(data: data.description),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: heigth * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isLogin()) {
                                controller.functionChangeTypeCart(false);
                                controller.functionAddCart(id: data.id);
                              } else {
                                showDialogAuth(context);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: primaryColor,
                              ),
                              child: Center(
                                child:
                                    state.loadingAddCart
                                        ? CircularProgressIndicator(
                                          color: white,
                                        )
                                        : SvgPicture.asset(
                                          "assets/icons/plus.svg",
                                        ),
                              ),
                            ),
                          ),

                          SizedBox(width: width * 0.05),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (isLogin()) {
                                  controller.functionChangeTypeCart(true);
                                  controller.functionAddCart(id: data.id);
                                } else {
                                  showDialogAuth(context);
                                }
                                 
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: orange,
                                ),
                                child:
                                    state.loadingAddCartGoCart
                                        ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                        : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/cart_nav.svg",
                                              color: white,
                                            ),
                                            SizedBox(width: width * 0.02),
                                            DefaultText(
                                              "Go To Cart".tr(),
                                              fontSize: 14,
                                              color: white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heigth * 0.05),
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
