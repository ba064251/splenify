import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:taskbysplenify/bloc/main_navbar_bloc/navbar_bloc.dart';
import 'package:taskbysplenify/bloc/main_navbar_bloc/navbar_event.dart';
import 'package:taskbysplenify/bloc/main_navbar_bloc/navbar_state.dart';
import 'package:taskbysplenify/constants/app_color.dart';
import 'package:taskbysplenify/constants/size_config.dart';
import 'package:taskbysplenify/views/category_screen.dart';
import 'package:taskbysplenify/views/favourite_screen.dart';
import 'package:taskbysplenify/views/product_screen.dart';
import 'package:taskbysplenify/views/profile_screen.dart';
import 'package:taskbysplenify/views/splash_screen.dart';

class MainNavbar extends StatefulWidget {
  const MainNavbar({super.key,});


  @override
  State<MainNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<MainNavbar> {
  final _productBox = Hive.box('product');
  final _categoryBox = Hive.box('category');
  int currentIndex = 0;

  void pageShifter(index){
    BlocProvider.of<NavbarBloc>(context).add(ChangeIndex(index));
  }

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NavbarBloc>(context).add(ChangeIndex(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List catData =  _categoryBox.get('categories') ?? [];
    List prodData = _productBox.get('products') ?? [];
    return BlocBuilder<NavbarBloc, NavbarState>(builder: (context, state) {
      if(state is IndexChanged){
        return Scaffold(
          body: state.index == 0 ? ProductScreen(prodData: prodData,) : state.index == 1 ? CategoryScreen(catData: catData,) : state.index == 2 ? const FavouriteScreen() : const ProfileScreen(),
          bottomNavigationBar: Container(
            color: backgroundBlack,
            child: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: backgroundBlack,),
              child: SizedBox(
                height: SizeConfig.screenHeight * 0.1,
                child: BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: backgroundWhite,
                    unselectedItemColor: backgroundWhite,
                    selectedIconTheme: const IconThemeData(color: backgroundWhite),
                    unselectedIconTheme: const IconThemeData(color: backgroundWhite),
                    currentIndex: state.index,
                    onTap: pageShifter,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.cases_sharp), label: 'Product'),
                      BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
                      BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: 'Heart'),
                      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mitt konto'),
                    ]),
              ),
            ),
          ),
        );
      }else if(state is IndexError){
        return Center(child: Text(state.errorMessage),);
      }else {
        return const SplashScreen();
      }
    },);
  }
}
