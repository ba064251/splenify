import 'package:flutter/material.dart';
import 'package:taskbysplenify/constants/app_color.dart';

import '../constants/size_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth * 1,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.heightMultiplier * 4,),

            // heading

            Center(
              child: Text('Mitt konto',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.textMultiplier * 4,
                  color: textColorBlack
              ),),
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 2.5,),

            Container(
              width: SizeConfig.screenWidth * 1,
              height: SizeConfig.screenHeight * 0.2,
              decoration: BoxDecoration(
                color: backgroundBlack,
                borderRadius: BorderRadius.circular(20)
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: backgroundWhite,
                  ),
                  SizedBox(width: SizeConfig.widthMultiplier * 4,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Basit Ali',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.textMultiplier * 3,
                          color: textColorWhite
                      ),),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5,),
                      Text('ba064251@gmail.com',style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          color: textColorWhite
                      ),),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5,),
                      Text('03102064659',style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          color: textColorWhite
                      ),),
                    ],
                  )
                ],
              )
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 2),

            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Kontoinstallningar'),
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 2),

            const ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Mina betalmetoder'),
            ),

            SizedBox(height: SizeConfig.heightMultiplier * 2),

            const ListTile(
              leading: Icon(Icons.support),
              title: Text('Support'),
            ),
          ],
        ),
      ),
    );
  }
}
