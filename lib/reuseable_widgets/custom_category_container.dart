import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/size_config.dart';

class CustomCategoryContainer extends StatelessWidget {
  const CustomCategoryContainer({
    super.key,
    required this.categoryImage,
    this.category
  });
  final String categoryImage;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return categoryImage == null ?
    Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.screenHeight * 0.4,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          color: backgroundBlack.withOpacity(0.1),
          image: const DecorationImage(image: AssetImage('images/error.jpg'))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,bottom: 14),
        child: category != null ? Text(category!,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.textMultiplier * 2,
            color: textColorBlack
        ),) : null,
      ),
    )  :Container(
      width: SizeConfig.screenWidth * 0.4,
      height: SizeConfig.screenHeight * 0.4,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          color: backgroundBlack.withOpacity(0.1),
          image: DecorationImage(image: NetworkImage(categoryImage))
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,bottom: 14),
        child: category != null ? Text(category!,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.textMultiplier * 2,
            color: textColorBlack
        ),) : null,
      ),
    );
  }
}
