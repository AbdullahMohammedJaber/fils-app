import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAccountWallet extends StatelessWidget {
  const AddAccountWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heigth * 0.06),
            Row(
              children: [
                ItemTitleBar(title: "E-wallet data".tr(), canBack: true),
                const Spacer(),
                Center(child: SvgPicture.asset("assets/icons/edit.svg")),
              ],
            ),
            SizedBox(height: heigth * 0.05),
            DefaultText(
              "Add a payment account".tr(),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xff433E3F),
            ),
            SizedBox(height: heigth * 0.08),
            GestureDetector(
              onTap: () {
                /*showCupertinoDialog(
                  context: context,
                  builder:
                      (context) => InfiniteScrollDialog(
                        endpoint: 'categories',
                        itemSearchString: (p0) => p0.name,
                        cacheKey: "category_addPayment",
                        callback: (item) {},
                        requestType: RequestType.get,
                        title: "Category".tr(),
                        itemBuilder: (context, item) {
                          return DefaultText(item.name);
                        },
                        parseResponse: (p0) => Datum.fromJson(p0),
                      ),
                );*/
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffE9E9E9)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/bank.svg"),
                      SizedBox(width: width * 0.03),
                      DefaultText(
                        "Name Bank".tr(),
                        color: const Color(0xff898384),
                      ),
                      const Spacer(),
                      Center(child: SvgPicture.asset("assets/icons/drob.svg")),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
