import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/features/coustamer/cart/item_delivery_methode.dart';
import 'package:fils/managment/order/order_seller_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';

import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({super.key});

  @override
  State<AddShippingAddress> createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  int? idAddress;

  String? nameArea;

  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          children: [
            SizedBox(height: heigth * 0.06),
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
                ],
              ),
            ),
            SizedBox(height: heigth * 0.06),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AreaFieldWidget(
                controller: area,
                onSelect: (selectedAddress) {
                  area.text = selectedAddress['name'];
                  idAddress = int.parse(selectedAddress['id'].toString());
                },
              ),
            ),
            SizedBox(height: heigth * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValidateWidget(
                validator: (value) {
                  if (address.text.isEmpty) {
                    return StringApp.requiredField;
                  } else {
                    return null;
                  }
                },
                child: TextFormFieldWidget(
                  hintText: "Address".tr(),
                  controller: address,
                  textInputType: TextInputType.name,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonWidget(
                onTap: () async {
                  if (!_key.currentState!.validate()) {
                  } else {
                    showBoatToast();
                    await DioClient(seller: true).request(
                      path: "shipping-adress/create",
                      method: 'POST',
                      data: {
                        "sector_id": idAddress,
                        "phone": getUser()!.user!.phone,
                        "address": address.text,
                        "shop_id": getMyShopsDetails().id,
                      },
                    );
                    closeAllLoading();
                    context.read<OrderSellerCubit>().getListShippingAddress();
                    Navigator.pop(context);
                  }
                },
                title: "Add".tr(),
                colorButton: primaryColor,
                heightButton: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
