 
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/address_manage/address_cubit.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const.dart';
 
import '../../../utils/setting_ui/loading_ui.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
 

class AddressWidget extends StatefulWidget {
    final Function(dynamic) callback;
  const AddressWidget({super.key, required this.callback});

 

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  void initState() {
   

    super.initState();
     context.read<AddressCubit>().getAddress();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
  return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            "Address".tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close)),
        ],
      ),

      content: SizedBox(
        width: double.maxFinite,
        height: heigth*0.7,
        child: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state.loadingAddress) {
              return LoadingUi();
            }
            else if (state.error != null) {
              return NeonNoInternetView(
                onRetry: () {
                  context.read<AddressCubit>().getAddress();
                },
                error: state.error!,
              );
            }
            else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.addressList!.length,
                itemBuilder: (context, index) {
                  final item = state.addressList![index];

                  return GestureDetector(
                    onTap: (){
                      widget.callback(item);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item['name'] , style: TextStyle(color: blackColor),),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
              );
            }
          },
        ),
      ),
    );
  }
}
