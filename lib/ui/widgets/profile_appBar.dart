import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import '../utilities/app_colors.dart';
import 'logout_alert_dialog.dart';


AppBar profile_appBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Get.to(()=>UpdateProfileScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(
                  base64Decode(AuthController.userData?.photo ?? ''))),
        ),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AuthController.userData?.fullName ?? '',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          AuthController.userData?.email ?? '',
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
