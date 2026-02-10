import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/wallet/wallet_seller_cubit.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
import 'package:fils/utils/const.dart';
 
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
 
class BankSetting extends StatefulWidget {
  const BankSetting({super.key});

  @override
  State<BankSetting> createState() => _BankSettingState();
}

class _BankSettingState extends State<BankSetting> {
  final _key = GlobalKey<FormState>();
  TextEditingController bankName = TextEditingController() ;
  TextEditingController bankNo = TextEditingController() ;
  TextEditingController ownerName = TextEditingController() ;
  TextEditingController bankIban = TextEditingController() ;



  _init() {
    ownerName.text = getUser()!.user!.name;
    if (getShopInfo().data!.bankName.toString() == "null" ||
        getShopInfo().data!.bankName == null) {
     bankName.clear();
    } else {
   bankName.text =
          getShopInfo().data!.bankName;
    }

  
    if (getShopInfo().data!.bankAccNo.toString() == "null" ||
        getShopInfo().data!.bankAccNo == null) {
      bankNo.clear();
    } else {
      bankNo.text =
          getShopInfo().data!.bankAccNo;
    } 
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletSellerCubit , WalletSellerState>(
      listener: (context, state) {
        
      },
      builder: (context, controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.06, width: width),
                    ItemTitleBar(  title: "Bank Settings".tr() , canBack: true,),
                    SizedBox(height: heigth * 0.05, width: width),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Bank Name".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if ( bankName.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: bankName,
                            onTap: () async {
                              bankName
                                  .text = await selectStringDialog(
                                context,
                                list: bankList,
                                title: "Select Bank".tr(),
                              );
                            },
                            hintText: "Central Bank of kuweit".tr(),
                            pathIconPrefix: "assets/icons/bank.svg",
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
                          "Owner Name".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if ( ownerName.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller:  ownerName,
                            textInputType: TextInputType.name,
                            hintText: "Owner Name".tr(),
                            pathIconPrefix: "assets/icons/bank.svg",
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
                          "Bank account number".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if ( bankNo.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller: bankNo,
                            textInputType: TextInputType.number,
                            hintText: "********".tr(),
                            pathIconPrefix: "assets/icons/product_image.svg",
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
                          "IBAN Number".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if ( bankIban.text.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            isPreffix: true,
                            controller:  bankIban,
                            textInputType: TextInputType.name,
                            hintText: "AHD996865854096055".tr(),
                            pathIconPrefix: "assets/icons/bank.svg",
                            isIcon: true,
                            pathIcon: "assets/icons/edit.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    SizedBox(width: width, height: heigth * 0.1),
                    ButtonWidget(
                      onTap: () async{
                        if (!_key.currentState!.validate()) {
                        } else {
                          context.read<WalletSellerCubit>().setupBankAccount(context, bankName: bankName.text,
                           ownerName: ownerName.text,
                            bankNo: bankNo.text,
                             bankIban: bankIban.text);
                        }
                      },
                      title: "Save Change".tr(),
                      colorButton: secondColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future selectStringDialog(
  BuildContext context, {
  required List<dynamic> list,
  required String title,
}) {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: true,

    builder: (context) {
      return CupertinoAlertDialog(
        title: DefaultText(title, fontSize: 20, fontWeight: FontWeight.w600),
        insetAnimationDuration: const Duration(seconds: 5),
        content: SizedBox(
          height: heigth * 0.45,
          child: ListView(
            children:
                list.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, e);
                      },
                      child: DefaultText(
                        e,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      );
    },
  );
}
  List<String> bankList = [
  "بنك الأهلي الكويتي - Ahli United Bank Kuwait",
  "بنك الكويت الوطني (NBK) - National Bank of Kuwait",
  "بنك بوبيان - Burgan Bank",
  "بنك الخليج الكويتي - Gulf Bank",
  "بنك الراجحي الكويتي - Al Rajhi Bank Kuwait",
  "بنك بوبلكس - Boubyan Bank",
  "بنك الكويت الدولي - Kuwait International Bank",
  "بنك وربة - Warba Bank",
  "بنك برقان - Al Tijari Bank",
  "بنك بريطانيا - Bank of Bahrain and Kuwait (BBK)",
  "البنك الصناعي الكويتي (Industrial Bank of Kuwait – IBK)",
  "بنك التجاري الكويتي (Commercial Bank of Kuwait)",
  "بي إن بي باريبا (BNP Paribas)",
  "إتش إس بي سي (HSBC)",
  "فيرست أبوظبي (FAB)",
  "سيتي بنك (Citibank)",
  "بنك قطر الوطني (QNB)",
  "بنك الدوحة (Doha Bank)",
  "بنك المشرق (Mashreq Bank)",
  "البنك السعودي الراجحي (Al‑Rajhi Bank)",
  "بنك مسقط (Bank Muscat)",
  "البنك الصناعي والتجاري الصيني (ICBC)",
  "بنك البحرين والكويت (BBK)",
];
}
