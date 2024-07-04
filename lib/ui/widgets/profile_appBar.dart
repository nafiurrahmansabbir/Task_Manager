import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

import '../screens/auth/sign_in_screen.dart';
import '../utilities/app_colors.dart';
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
          'Nafiur Rahman Sabbir',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          'nafiurrahmansabbir@gmail.com',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ],
    ),
    actions: [
      IconButton(

        onPressed: () {
          // if(fromUpdateProfile){
          //   return;
          // }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        },
        icon: Icon(
          Icons.logout_sharp,
          color: Colors.white70,
        ),
      )
    ],
  );
}
