import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:searchfield/searchfield.dart';
import 'package:taskbysplenify/views/product_screen.dart';
import '../constants/app_color.dart';
import '../constants/size_config.dart';
import '../reuseable_widgets/custom_category_container.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.catData});
  final List catData;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController searchController = TextEditingController();
  final _productBox = Hive.box('product');
  final FocusNode _focusNode = FocusNode();
  bool _suggestion = false;

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
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List prodData = _productBox.get('products') ?? [];
    final searchItems = widget.catData!
        .map((item) => SearchFieldListItem(item['slug']!, child: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(categoryType: item['slug'],prodData: prodData,),));
      },
      child: ListTile(
        title: Text(item['slug']),
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
              child: Text('Category',style: TextStyle(
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

            Text('${widget.catData.length} results found',style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.textMultiplier * 1.4,
                color: textColorBlack.withOpacity(0.4)
            ),),

            SizedBox(height: SizeConfig.heightMultiplier * 2,),

            widget.catData.length != 0 ? SizedBox(
                width: SizeConfig.screenWidth * 1,
                height: SizeConfig.screenHeight * 0.62,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemCount: widget.catData.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(categoryType: widget.catData[index]['slug'],prodData: prodData,),));
                      },
                      child: CustomCategoryContainer(
                        categoryImage: '',
                        category: widget.catData[index]['name'],
                      ),
                    );
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

