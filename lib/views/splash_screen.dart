import 'package:flutter/material.dart';
import 'package:taskbysplenify/constants/app_color.dart';
import 'package:taskbysplenify/constants/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final String shortDesc = "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth * 1,
        height: SizeConfig.screenHeight * 1,
        child: Stack(
          children: [

            // Image Section
            Container(
              height: SizeConfig.screenHeight * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/splash.jpg'))
              ),
            ),

            SizedBox(
              width: SizeConfig.screenWidth * 1,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 10,),

                  // Heading
                  Text('My Store',style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.textMultiplier * 4,
                    color: textColorBlack
                  ),),

                  SizedBox(height: SizeConfig.heightMultiplier * 60,),
                  // Sub Heading
                  Text('Valkommen',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: textColorWhite
                  ),),

                  SizedBox(height: SizeConfig.heightMultiplier * 1,),

                  // short desc
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.7,
                    child: Text(shortDesc,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.textMultiplier * 1.4,
                        color: textColorWhite
                    ),textAlign: TextAlign.center,),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
