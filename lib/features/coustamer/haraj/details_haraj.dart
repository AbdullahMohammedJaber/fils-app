import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/haraj/phone_text.dart';
import 'package:fils/managment/haraj/haraj_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/data/response/haraj/details_haraj.dart';
import '../../../utils/const.dart';
import '../../../utils/storage.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import 'header_details_product_open_market.dart';

class DetailsHaraj extends StatefulWidget {
  final String slug;

  const DetailsHaraj({super.key, required this.slug});

  @override
  State<DetailsHaraj> createState() => _DetailsHarajState();
}

class _DetailsHarajState extends State<DetailsHaraj> {
  @override
  void initState() {
    context.read<HarajCubit>().getDetailsHaraj(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),

      body: BlocBuilder<HarajCubit, HarajState>(
        builder: (context, state) {
          if (state.loadingDetails) {
            return LoadingUi();
          } else if (state.errorDetails != null) {
            return NeonNoInternetView(
              onRetry: () {
                context.read<HarajCubit>().getDetailsHaraj(widget.slug);
              },
              error: state.errorDetails!,
            );
          } else {
            if (state.detailsOpenMarketResponse == null) {
              return SizedBox();
            } else {
              DetailsOpenMarketResponseDatum details =
                  state.detailsOpenMarketResponse!.data![0];
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    details.photos!.data!.isNotEmpty ||
                            details.thumbnailImage!.data!.isNotEmpty
                        ? HeaderDetailsProductOpenMarket(details: details)
                        : const SizedBox(),
                    SizedBox(height: heigth * 0.03),
      
                    // Category Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DefaultText(
                        details.category,
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: heigth * 0.001),
                    // Product Name
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DefaultText(
                              details.name,
                              color: blackColor,
                              fontSize: 16,
                              overflow: TextOverflow.visible,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DefaultText(
                        "${details.unitPrice}",
                        color: secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: heigth * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          details.location == null
                              ? const SizedBox()
                              : DefaultText(
                                "Address".tr(),
                                fontSize: 14,
                                color: const Color(0xff5A5555),
                                fontWeight: FontWeight.w500,
                              ),
                          SizedBox(height: heigth * 0.01),
                          details.location == null
                              ? const SizedBox()
                              : SizedBox(
                                width: width * 0.85,
                                child: DefaultText(details.location),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: heigth * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          details.phone == null
                              ? const SizedBox()
                              : DefaultText(
                                "Mobile Number".tr(),
                                fontSize: 14,
                                color: const Color(0xff5A5555),
                                fontWeight: FontWeight.w500,
                              ),
                          SizedBox(height: heigth * 0.01),
                          PhoneText(phone: details.phone!),
                        ],
                      ),
                    ),
                    SizedBox(height: heigth * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          details.description == null
                              ? const SizedBox()
                              : DefaultText(
                                "Product Details".tr(),
                                fontSize: 14,
      
                                color: const Color(0xff5A5555),
                                fontWeight: FontWeight.w500,
                              ),
                          SizedBox(height: heigth * 0.01),
                          details.description == null
                              ? const SizedBox()
                              : SizedBox(
                                width: width * 0.85,
                                child: DefaultText(
                                  details.description,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: heigth * 0.05),
                    if (details.addedBy == getUser()!.user!.name)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () async {
                            context.read<HarajCubit>().deleteHaraj(state.detailsOpenMarketResponse!.data![0].id!);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/delete_red.svg",
                                  ),
                                ),
                              ),
                              DefaultText("Delete Product".tr()),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
