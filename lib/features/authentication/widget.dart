import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/theme/color_manager.dart';

Widget buildSocialMediaAuth({
    String? path,
  required Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: grey2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(path!=null)
          SvgPicture.asset(
            path ,
            color: path.endsWith("apple.svg") ? blackColor : null,
          ),
          SizedBox(width: 10),
          DefaultText(
          path!=null?  path.endsWith("apple.svg")
                ? "Login with apple account".tr()
                : "Login with google account".tr() : "Login as guest".tr(),
            fontSize: 10,
          ),
        ],
      ),
    ),
  );
}

void pickCountry(BuildContext context) {
  showCountryPicker(
    useSafeArea: true,
    context: context,
    showPhoneCode: true,

    onSelect: (Country country) {
      context.read<AuthCubit>().changeCountry(country);
    },
    countryListTheme: CountryListThemeData(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      inputDecoration: const InputDecoration(
        labelText: 'بحث عن الدولة',
        hintText: 'اكتب اسم الدولة هنا...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget picker(BuildContext context) {
  return BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {},
    builder: (context, state) {
      var controller = context.read<AuthCubit>();
      return InkWell(
        onTap: () {
          pickCountry(context);
        },
        child: Container(
          width: 100,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (controller.state.country != null)
                Text(
                  controller.state.country!.flagEmoji,
                  style: const TextStyle(fontSize: 15),
                ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  controller.state.country != null
                      ? '${controller.state.country!.countryCode} (+${controller.state.country!.phoneCode})'
                      : 'Select Country'.tr(),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    },
  );
}
