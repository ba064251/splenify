import 'package:flutter/material.dart';
import 'package:taskbysplenify/constants/size_config.dart';
import 'package:taskbysplenify/views/product_description_screen.dart';
import '../constants/app_color.dart';
import '../reuseable_widgets/custom_product_container.dart';
import 'package:searchfield/searchfield.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, this.prodData, this.categoryType});
  final List? prodData;
  final String? categoryType;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _suggestion = false;

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    _focusNode.addListener((){
      setState(() {
        _suggestion = _focusNode.hasFocus;
      });
    });super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchItems = widget.prodData!
        .map((item) => SearchFieldListItem(item['title']!, child: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDescriptionScreen(productID: item['id']),));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item['thumbnail']),
        ),
        title: Text(item['title']),
        subtitle: Text('In ${item['category']}'),
      ),
    )))
        .toList();
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
              child: Text('Products',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.textMultiplier * 4,
                  color: textColorBlack
              ),),
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 1,),

            // search field

            SearchField(
              suggestions: searchItems,
              focusNode: _focusNode,
              maxSuggestionsInViewPort: 5,
              itemHeight: 10 * SizeConfig.heightMultiplier,
              hint: 'Search for Products',
              suggestionsDecoration: SuggestionDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              suggestionItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                      width: 1.0)),
              searchInputDecoration: SearchInputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: backgroundBlack,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: backgroundBlack,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                prefixIcon: Icon(Icons.search,color: backgroundBlack,)
              ),
              marginColor: Colors.grey.shade300,
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 1.5,),

            // results count

            Text('${widget.prodData!.length} results found',style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.textMultiplier * 1.4,
                color: textColorBlack.withOpacity(0.4)
            ),),

            SizedBox(height: SizeConfig.heightMultiplier * 2,),

            widget.prodData!.length != 0 ? SizedBox(
              width: SizeConfig.screenWidth * 1,
              height: SizeConfig.screenHeight * 0.62,
              child: widget.categoryType == null ?
              ListView.builder(
                itemCount: widget.prodData!.length,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return // main product divs
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDescriptionScreen(productID: widget.prodData![index]['id']),));
                      },
                      child: CustomProductContainer(
                        productName: widget.prodData![index]['title'],
                        productImage: widget.prodData![index]['thumbnail'],
                        productPrice: widget.prodData![index]['price'],
                        productRating: widget.prodData![index]['rating'],
                        productCategory: 'In ${widget.prodData![index]['tags'][0]}',
                        productVendor: widget.prodData![index]['brand'],
                      ),
                    );
                },)
                  :
              ListView.builder(
                itemCount: widget.prodData!.length,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                 if(widget.categoryType == widget.prodData![index]['category']){
                   return // main product divs
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDescriptionScreen(productID: widget.prodData![index]['id']),));
                       },
                       child: CustomProductContainer(
                         productName: widget.prodData![index]['title'] ?? '',
                         productImage: widget.prodData![index]['thumbnail'] ?? '',
                         productPrice: widget.prodData![index]['price'] ?? 0.00,
                         productRating: widget.prodData![index]['rating'] ?? 0.00,
                         productCategory: 'In ${widget.prodData![index]['tags'][0]}' ?? '',
                         productVendor: widget.prodData![index]['brand'] ?? '',
                       ),
                     );
                 }
                 else{
                   return Container();
                 }
                },)
            ) : Center(
              child: Text('Close and Re-Open Application',style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.textMultiplier * 2,
                  color: textColorBlack
              ),),
            ),
          ],
        ),
      ),
    );
  }
}


