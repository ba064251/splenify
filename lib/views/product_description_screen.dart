import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taskbysplenify/constants/size_config.dart';
import 'package:taskbysplenify/services/api_service.dart';

import '../constants/app_color.dart';
import '../reuseable_widgets/custom_category_container.dart';
import '../services/favourite_service.dart';

class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({super.key, required this.productID});
  final int productID;

  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {

  final String productDescription = "Lorem Ipsum är en utfyllnadstext från tryck- och förlagsindustrin. Lorem ipsum har varit standard ända";
  final APIServices _apiServices = APIServices();
  final FavouriteService _favouriteService = FavouriteService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth * 1,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: FutureBuilder(future:  _apiServices.getSpecificProducts(widget.productID), builder:  (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: backgroundBlack,),);
            }
            else if(snapshot.hasData){

              Map productData = jsonDecode(snapshot.data);
              List productImages = productData['images'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SizeConfig.heightMultiplier * 2,),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.chevron_left, size: 30,)),
                        Text('Product Details',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 3,
                            color: textColorBlack
                        ),),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 6,
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: SizeConfig.heightMultiplier * 1,),


                  Container(
                    width: SizeConfig.screenWidth * 1,
                    height: SizeConfig.screenHeight * 0.35,
                    decoration: BoxDecoration(
                        color: backgroundBlack.withOpacity(0.1),
                        image: DecorationImage(image: NetworkImage(productData['thumbnail']))
                    ),
                  ),

                  SizedBox(height: SizeConfig.heightMultiplier * 1.5,),


                  Container(
                    width: SizeConfig.screenWidth * 1,
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Product Details:',style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.textMultiplier * 2.5,
                                color: textColorBlack
                            ),),
                            IconButton(onPressed: (){
                              _favouriteService.addProduct(productData, context);
                            }, icon: const Icon(Icons.heart_broken_sharp))
                          ],
                        ),

                        CustomTypeWidget(
                          type: 'Name',
                          value: productData['title'],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        CustomTypeWidget(
                          type: 'Price',
                          value: "\$${productData['price']}",
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        CustomTypeWidget(
                          type: 'Category',
                          value: productData['tags'][0],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        CustomTypeWidget(
                          type: 'Brand',
                          value: productData['brand'],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        Row(
                          children: [
                            Text('${productData['rating']}',style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.textMultiplier * 1.4,
                                color: textColorBlack
                            ),),
                            RatingBar(
                              initialRating: productData['rating'],
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 12.0,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                              onRatingUpdate: (rating) {
                              }, ratingWidget: RatingWidget(full: const Icon(Icons.star,color: amberColor,), half: const Icon(Icons.star_half,color: amberColor,), empty: const Icon(Icons.star_border_rounded,color: amberColor,)),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        CustomTypeWidget(
                          type: 'Stock',
                          value: '${productData['stock']}',
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        Text('Description:',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2,
                            color: textColorBlack
                        )),
                        Text('${productData['description']}',style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.textMultiplier * 2,
                            color: textColorBlack
                        ),textAlign: TextAlign.left,),
                        SizedBox(height: SizeConfig.heightMultiplier * 2,),
                        Text('Product Gallery:',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.textMultiplier * 2,
                            color: textColorBlack
                        )),
                        GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10
                          ),
                          itemCount: productImages.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomCategoryContainer(
                              categoryImage: productImages[index],
                            );
                          },)
                      ],
                    ),
                  ),

                ],
              );
            }
            else{
              return const Center(child: Icon(Icons.error,color: Colors.red,),);
            }
          },),
        ),
      ),
    );
  }
}

class CustomTypeWidget extends StatelessWidget {
  const CustomTypeWidget({
    super.key,
    required this.type,
    required this.value
  });
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$type:',style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.textMultiplier * 2,
            color: textColorBlack
        ),),
        Text(value ?? '',style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.textMultiplier * 2,
            color: textColorBlack
        ),)
      ],
    );
  }
}
