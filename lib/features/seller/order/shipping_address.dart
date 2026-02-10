import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/managment/order/order_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';

import 'package:fils/utils/const.dart';

import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';

import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

class ShippingAdress extends StatefulWidget {
  final int order_id;

  const ShippingAdress({super.key, required this.order_id});

  @override
  State<ShippingAdress> createState() => _ShippingAdressState();
}

class _ShippingAdressState extends State<ShippingAdress> {
  @override
  void initState() {
    super.initState();
    GetStorage().remove('shipping');
    context.read<OrderSellerCubit>().getListShippingAddress();
  }

  @override
  void dispose() {
    super.dispose();
    GetStorage().remove('shipping');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: width, height: heigth * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
                DefaultText(
                  "Shipping address".tr(),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: primaryDarkColor,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (getUser()!.user!.phone!.isEmpty) {
                      showMessage(
                        "Please fill Phone number".tr(),
                        value: false,
                      );
                      To(AppRoutes.editPersonalInformationScreen);
                    } else {
                      if (getMyShopsDetails().id != 0) {
                        ToWithFade(AppRoutes.addShippingAddress);
                      } else {
                        showMessage(
                          "Please Select your Shop".tr(),
                          value: false,
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: secondColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/icons/plus.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<OrderSellerCubit, OrderSellerState>(
              builder: (context, state) {
                if (state.loadingListShippingAddress) {
                  return LoadingUi();
                } else if (state.errorListShippingAddress != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<OrderSellerCubit>().getListShippingAddress();
                    },
                    error: state.errorListShippingAddress!,
                  );
                } else if (state.listShippingAddress != null) {
                  if (state.listShippingAddress!.isEmpty) {
                    return EmptyDataScreen();
                  } else {
                    final address = state.listShippingAddress;
                    return NotificationListener(
                      child: ListView.builder(
                        itemCount: address!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                address[index].isSelect = true;
                              });
                              setShippingAddress(address[index]);
                            },
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    DefaultText(
                                      address[index].address,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child:
                                          address[index].isSelect &&
                                                  getShippingAddress().id ==
                                                      address[index].id
                                              ? Container(
                                                color: primaryColor,
                                                height: 20,
                                                width: 20,
                                              )
                                              : const SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ButtonWidget(
              onTap: () async {
                if (getShippingAddress().id == null) {
                  showMessage(value: false, "Please Select Address".tr());
                } else {
                  showBoatToast();
                  final result = await DioClient(seller: true).request(
                    path: "shipping-adress/ship-order",
                    method: 'POST',
                    data: {
                      "order_id": widget.order_id,
                      "seller_address_id": getShippingAddress().id,
                    },
                  );

                  closeAllLoading();
                  if (result.statusCode == 200) {
                    showMessage(result.data['message'], value: true);
                    Navigator.pop(context);
                  } else {
                    showMessage(result.message, value: false);
                  }
                }
              },
              title: "Sipping".tr(),
              colorButton: primaryColor,
              heightButton: 45,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
