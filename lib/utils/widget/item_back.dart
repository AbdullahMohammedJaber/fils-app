import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemBack extends StatelessWidget {
  final String title;
  const ItemBack({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              height: 40,
              width: 40,
              child: Center(child: SvgPicture.asset("assets/icons/arrow.svg")),
            ),
          ),
          Spacer(),
          DefaultText(title , fontSize: 20, fontWeight: FontWeight.w600,),
          Spacer(),
        ],
      ),
    );
  }
}
