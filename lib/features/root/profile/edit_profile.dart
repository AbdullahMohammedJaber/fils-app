// ignore_for_file: must_be_immutable

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _key = GlobalKey<FormState>();

  TextEditingController nameControllerForEdit = TextEditingController();

  TextEditingController phoneControllerForEdit = TextEditingController();

  TextEditingController emailControllerForEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameControllerForEdit.text = getUser()!.user!.name;

    emailControllerForEdit.text = getUser()!.user!.email;
    if (getUser()!.user!.phone!.isNotEmpty) {
      phoneControllerForEdit.text = getUser()!.user!.phone!.substring(
        3,
        getUser()!.user!.phone!.length,
      );
      _setCountryFromPhone(getUser()!.user!.phone!);
    }
  }

  Country? _selectedCountry;

  void _pickCountry() {
    showCountryPicker(
      useSafeArea: true,
      context: context,
      showPhoneCode: true,

      onSelect: (Country country) {
        print(country.toJson().toString());
        setState(() {
          _selectedCountry = country;
        });
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

  void _setCountryFromPhone(String fullNumber) {
    fullNumber = fullNumber.replaceAll("+", "");
    print(fullNumber);

    List<String> possibleCodes = [
      fullNumber.substring(0, 1),
      if (fullNumber.length >= 2) fullNumber.substring(0, 2),
      if (fullNumber.length >= 3) fullNumber.substring(0, 3),
    ];

    final allCountries = CountryService().getAll();

    for (String code in possibleCodes) {
      try {
        final match = allCountries.firstWhere((c) => c.phoneCode == code);
        print(match);
        if (match.countryCode != 'WORLD') {
          setState(() {
            _selectedCountry = match;
          });
          print("Country detected: ${match.name}");
          return;
        }
      } catch (_) {}
    }

    print("No country matched");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.06),
                    ItemTitleBar(
                      title: "Edit Personal information".tr(),
                      canBack: true,
                    ),
                    SizedBox(height: heigth * 0.08),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Full Name".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (nameControllerForEdit.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: nameControllerForEdit,
                            isPreffix: true,
                            textInputType: TextInputType.name,
                            hintText: "Full Name".tr(),
                            pathIconPrefix: "assets/icons/user.svg",
                            isIcon: true,
                            pathIcon: "assets/icons/edit.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "E - mail".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (emailControllerForEdit.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: emailControllerForEdit,
                            isPreffix: true,
                            textInputType: TextInputType.emailAddress,
                            hintText: "E - mail".tr(),
                            pathIconPrefix: "assets/icons/sms.svg",
                            isIcon: true,
                            pathIcon: "assets/icons/edit.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Mobile Number".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (phoneControllerForEdit.text.isEmpty) {
                              return StringApp.requiredField;
                            } else if (_selectedCountry == null) {
                              return "Please select a country".tr();
                            } else if (!RegExp(
                              r'^[0-9]+$',
                            ).hasMatch(phoneControllerForEdit.text)) {
                              return "The number must contain only numbers."
                                  .tr();
                            } else if (phoneControllerForEdit.text.length < 6 ||
                                phoneControllerForEdit.text.length > 12) {
                              return "Please enter a valid number".tr();
                            } else {
                              return null;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: phoneControllerForEdit,
                                  isPreffix: true,
                                  textInputType: TextInputType.phone,
                                  hintText: "Mobile Number".tr(),
                                  pathIconPrefix: "assets/icons/mobile.svg",
                                ),
                              ),
                              InkWell(
                                onTap: _pickCountry,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      if (_selectedCountry != null)
                                        Text(
                                          _selectedCountry!.flagEmoji,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          _selectedCountry != null
                                              ? '${_selectedCountry!.countryCode} (+${_selectedCountry!.phoneCode})'
                                              : 'Select Country'.tr(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: heigth * 0.1),
                    ButtonWidget(
                      title:
                          state.loadingEditProfile
                              ? state.loadingEditProfile
                              : "Save Change".tr(),
                      colorButton: secondColor,
                      fontType: FontType.bold,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthCubit>().editProfile(
                          code: _selectedCountry!.phoneCode,
                          email: emailControllerForEdit.text,
                          name: nameControllerForEdit.text,
                          phone: phoneControllerForEdit.text,
                        );
                      },
                    ),
                    SizedBox(height: heigth * 0.1),
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
