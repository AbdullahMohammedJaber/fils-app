import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/managment/category/category_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
 import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogShowCategory extends StatefulWidget {
  final Function(dynamic) callback;

  const DialogShowCategory({super.key, required this.callback});

  @override
  State<DialogShowCategory> createState() => _DialogShowCategoryState();
}

class _DialogShowCategoryState extends State<DialogShowCategory> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().functionFetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            "Category".tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close)),
        ],
      ),

      content: SizedBox(
        width: double.maxFinite,
        height: heigth*0.7,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state.loading) {
              return LoadingUi();
            }
            else if (state.error != null) {
              return NeonNoInternetView(
                onRetry: () {
                  context.read<CategoryCubit>().functionFetchCategory();
                },
                error: state.error!,
              );
            }
            else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.categoryResponse!.data.length,
                itemBuilder: (context, index) {
                  final item = state.categoryResponse!.data[index];

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
                      child: Text(item.name , style: TextStyle(color: blackColor),),
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



class DialogShowMultiCategory extends StatefulWidget {
  final Function(List<Category> ids) callback;
  final int categoryId;
  const DialogShowMultiCategory({super.key, required this.callback ,required this.categoryId});

  @override
  State<DialogShowMultiCategory> createState() => _DialogShowMultiCategoryState();
}

class _DialogShowMultiCategoryState extends State<DialogShowMultiCategory> {
   final Set<Category> _selectedIds = {};

  @override
  void initState() {
    context.read<CategoryCubit>().functionFetchSubCategory(categoryId: widget.categoryId);
 
    super.initState();
  }
void _toggle(Category item) {
    setState(() {
      if (_selectedIds.contains(item )) {
        _selectedIds.remove(item );
      } else {
        _selectedIds.add(item);
      }
    });
  }
   @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            "Category".tr(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),

      content: SizedBox(
        width: double.maxFinite,
        height: heigth * 0.7,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state.loading) {
              return LoadingUi();
            } 
            else if (state.error != null) {
              return NeonNoInternetView(
                onRetry: () {
                  context.read<CategoryCubit>().functionFetchCategory();
                },
                error: state.error!,
              );
            } 
            else {
              return ListView.separated(
                itemCount: state.categoryResponse!.data.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = state.categoryResponse!.data[index];
                  final isSelected = _selectedIds.contains(item);

                  return InkWell(
                    onTap: () => _toggle(item),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryColor.withOpacity(0.15)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? primaryColor
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _toggle(item),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel".tr()),
        ),
         SizedBox(
          width: width*0.35,
           child: ButtonWidget(
            onTap: _selectedIds.isEmpty
                ? (){}
                : () {
                    widget.callback(_selectedIds.toList());
                    Navigator.pop(context);
                  },
                  title: "Confirm".tr(),
           ),
         ),
      ],
    );
  }
}

 
