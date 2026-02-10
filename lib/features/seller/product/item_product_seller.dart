import 'package:cached_network_image/cached_network_image.dart';
 import 'package:fils/core/data/response/home/home_seller_response.dart';
import 'package:fils/core/data/response/product/all_product_seller.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/flip_view.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
 

import 'package:fils/utils/const.dart';
 
import 'package:fils/utils/theme/color_manager.dart';
 
class ProductItemWidget extends StatefulWidget {
  final ProductSeller? productListModel;

  const ProductItemWidget({super.key, this.productListModel});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          ToWithFade(AppRoutes.detailsPriductSeller , arguments: widget.productListModel!.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: white),
        ),
        color: getTheme() ? Colors.black : white,
        elevation: getTheme() ? 0 : 4,
        child: Container(
          width: width * 0.46,

          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heigth * 0.01),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: CachedNetworkImage(
                    imageUrl: widget.productListModel!.thumbnailImg,
                    placeholder: (context, url) => const LoadingUi(),
                    errorWidget:
                        (context, url, error) =>
                            Image.asset("assets/images/fils_logo_f.png"),
                    height: heigth * 0.2,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: heigth * 0.01),
              DefaultText(
                widget.productListModel!.name,
                color: getTheme() ? white : blackColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: heigth * 0.005),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/store_nav.svg"),
                  SizedBox(width: width * 0.01),
                  Expanded(
                    child: DefaultText(
                       getMyShopsDetails().name,
                      color: getTheme() ? white : textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultText(
                    widget.productListModel!.price.toString(),
                    color: secondColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: FlipView(
                        child: SvgPicture.asset(
                          "assets/icons/go_product.svg",
                          color: getTheme() ? white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItemWidget2 extends StatefulWidget {
  final BestProduct? productListModel;

  const ProductItemWidget2({super.key, this.productListModel});

  @override
  State<ProductItemWidget2> createState() => _ProductItemWidget2State();
}

class _ProductItemWidget2State extends State<ProductItemWidget2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          ToWithFade(AppRoutes.detailsPriductSeller , arguments: widget.productListModel!.id);
        
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Container(
          width: width * 0.46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: CachedNetworkImage(
                    imageUrl: widget.productListModel!.thumbnailImage,
                    placeholder: (context, url) => const LoadingUi(),
                    errorWidget:
                        (context, url, error) =>
                            Image.asset("assets/images/fils_logo_f.png"),
                    height: heigth * 0.2,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: heigth * 0.01),
              DefaultText(
                widget.productListModel!.name,
                color: blackColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: heigth * 0.005),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/store_nav.svg"),
                  SizedBox(width: width * 0.01),
                  Expanded(
                    child: DefaultText(
                       getMyShopsDetails().name,
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultText(
                    widget.productListModel!.basePrice.toString(),
                    color: secondColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                      child: FlipView(
                        child: SvgPicture.asset("assets/icons/go_product.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
