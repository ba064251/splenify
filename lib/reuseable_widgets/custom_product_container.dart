import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants/app_color.dart';
import '../constants/size_config.dart';

class CustomProductContainer extends StatelessWidget {
  const CustomProductContainer({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productRating,
    required this.productVendor,
    required this.productCategory,
  });
  final String productImage;
  final String productName;
  final double productPrice;
  final double productRating;
  final String productVendor;
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 1,
      height: SizeConfig.screenHeight * 0.4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: backgroundBlack.withOpacity(0.3),
            spreadRadius: 0.6,
            blurRadius: 4
          )
        ]
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // product image container

          Center(
            child: Container(
              constraints: BoxConstraints(
                minWidth: SizeConfig.screenWidth * 0.85,
                maxWidth: SizeConfig.screenWidth * 0.85,
                minHeight: SizeConfig.screenHeight * 0.25 ,
                maxHeight: SizeConfig.screenHeight * 0.25,
              ),
              decoration: BoxDecoration(
                  color: backgroundBlack.withOpacity(0.1),
                  image: DecorationImage(image: NetworkImage(productImage))
              ),
            ),
          ),

          // product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName,style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.textMultiplier * 2.5,
                          color: textColorBlack
                      ),),

                      Row(
                        children: [
                          Text('$productRating',style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.textMultiplier * 1.4,
                              color: textColorBlack
                          ),),
                          productRating!=null?RatingBar(
                            initialRating: productRating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 12.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                            onRatingUpdate: (rating) {
                            }, ratingWidget: RatingWidget(full: const Icon(Icons.star,color: amberColor,), half: const Icon(Icons.star_half,color: amberColor,), empty: const Icon(Icons.star_border_rounded,color: amberColor,)),
                          ):Container()
                        ],
                      ),

                      //vendor name
                      Text(productVendor,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          color: textColorBlack.withOpacity(0.4)
                      ),),

                      SizedBox(height: SizeConfig.heightMultiplier * 1,),

                      // Category
                      Text(productCategory,style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          color: textColorBlack
                      ),),

                    ],
                  ),
                ),

                // product price

                Text('\$$productPrice',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.textMultiplier * 2.5,
                    color: textColorBlack
                ),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
