import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskbysplenify/bloc/api_bloc/api_bloc.dart';
import 'package:taskbysplenify/bloc/api_bloc/api_state.dart';
import 'package:taskbysplenify/bloc/main_navbar_bloc/navbar_bloc.dart';
import 'package:taskbysplenify/constants/size_config.dart';
import 'package:taskbysplenify/services/api_service.dart';
import 'package:taskbysplenify/views/main_navbar.dart';
import 'package:taskbysplenify/views/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/api_bloc/api_event.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('favourite');
  await Hive.openBox('product');
  await Hive.openBox('category');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(providers: [
      BlocProvider<NavbarBloc>(create: (context) => NavbarBloc(),),
      BlocProvider<ApiBloc>(create: (context) => ApiBloc(APIServices()),),
    ], child: SafeArea(
      top: true,
      child: MaterialApp(
        home: const ScreenSwitcher(),
        title: 'Task By Splenify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
        ),
        darkTheme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
        ),
      ),
    ));
  }
}

class ScreenSwitcher extends StatefulWidget {
  const ScreenSwitcher({super.key});

  @override
  State<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends State<ScreenSwitcher> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ApiBloc>(context).add(GettingData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiBloc, ApiState>(builder: (context, state) {
      if(state is APIDataLoading){
        return const SplashScreen();
      }
      else if(state is APIDataGet){
        Future.delayed(const Duration(seconds: 2),() {
          return const SplashScreen();
        },);
        return const MainNavbar();
      } else if(state is APIDataError){
        return Center(child: Text(state.errorMessage,style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 1.4,
          color: Colors.red,
          fontWeight: FontWeight.w600
        ),),);
      }else {
        return const Icon(Icons.error, color: Colors.red);
      }
    },);
  }
}

