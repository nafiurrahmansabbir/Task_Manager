import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

import '../screens/auth/sign_in_screen.dart';
import '../utilities/app_colors.dart';
import 'logout_alert_dialog.dart';
import 'network_cached_image.dart';

AppBar profile_appBar(context,[bool fromUpdateProfile=false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if(fromUpdateProfile){
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateProfileScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 10,
          // child: NetworkCachedImage(
          //   url: '',
          // ),
        ),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AuthController.userData?.fullName??'',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          AuthController.userData?.email??'',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ],
    ),
    actions: [
      IconButton(

        onPressed: () {
          logout_alert_dialog(context);
        },
        icon: Icon(
          Icons.logout_sharp,
          color: Colors.white70,
        ),
      )
    ],
  );
}
