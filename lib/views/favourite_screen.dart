import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:taskbysplenify/services/favourite_service.dart';

import '../constants/app_color.dart';
import '../constants/size_config.dart';
import '../reuseable_widgets/custom_textformfield.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {


  final TextEditingController searchController = TextEditingController();

  final String boxName = 'productBox';
  final favourite = Hive.box('favourite');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List prodData = favourite.get('favourite') ?? [];
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth * 1,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: SizeConfig.heightMultiplier * 4,),

            // heading

            Center(
              child: Text('Favourites',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.textMultiplier * 4,
                  color: textColorBlack
              ),),
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 1,),

            // search field

            CustomTextFormField(
              hintText: 'Search Favourites',
              searchController: searchController,
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 1.5,),

            // results count

            Text('${prodData.length} results found',style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.textMultiplier * 1.4,
                color: textColorBlack.withOpacity(0.4)
            ),),

            SizedBox(height: SizeConfig.heightMultiplier * 2,),

            SizedBox(
                width: SizeConfig.screenWidth * 1,
                height: SizeConfig.screenHeight * 0.62,
                child: prodData.length != 0 ?
                ListView.builder(
                  itemCount: prodData.length,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = prodData[index];
                    return // main product divs
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(product['thumbnail']),
                            backgroundColor: backgroundBlack.withOpacity(0.1),
                          ),
                          title:  Text(product['title'] ?? '',style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColorBlack
                          ),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${product['price']}',style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: textColorBlack
                              ),),
                              Row(
                                children: [
                                  Text('${product['rating']}',style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.textMultiplier * 1.4,
                                      color: textColorBlack
                                  ),),
                                  RatingBar(
                                    initialRating: double.parse('${product['rating']}'),
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
                            ],
                          ),
                          trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.heart_broken_sharp)),
                        ),
                      );
                  },)
                    : const Center(child: Text('No Favourite Found'),)
            )
          ],
        ),
      ),
    );

  }
}
