import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import 'package:task_manager/ui/widgets/custom_tost_massage.dart';
import 'package:task_manager/ui/widgets/profile_appBar.dart';

import '../../data/utilities/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();
  final TextEditingController _firstnameTeController = TextEditingController();
  final TextEditingController _lastnameTeController = TextEditingController();
  final TextEditingController _mobileTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userData = AuthController.userData!;
    _emailTeController.text = userData.email ?? '';
    _firstnameTeController.text = userData.firstName ?? '';
    _lastnameTeController.text = userData.lastName ?? '';
    _mobileTeController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profile_appBar(context, true),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildPhotoPickerWidget(),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTeController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _firstnameTeController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _lastnameTeController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileTeController,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordTeController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: _updateProfileInProgress==false,
                    replacement: CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: Container(
          width: double.maxFinite,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                width: 80,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Photo',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(
                _selectImage?.name ?? 'No Image selected ',
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ))
            ],
          )),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    String encodePhoto = AuthController.userData?.photo ?? '';
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestBody = {
      "email": _emailTeController.text,
      "firstName": _firstnameTeController.text.trim(),
      "lastName": _lastnameTeController.text.trim(),
      "mobile": _mobileTeController.text.trim(),
    };

    if (_passwordTeController.text.isNotEmpty) {
      requestBody['password'] =_passwordTeController.text;
    }

    if (_selectImage != null) {
      File file = File(_selectImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodePhoto;
    }
    final NetworkResponse response =
    await NetworkCaller.postRequest(Urls.updateProfile, body: requestBody);
    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userModel = UserModel(
        email: _emailTeController.text,
        photo: encodePhoto,
        firstName: _firstnameTeController.text.trim(),
        lastName: _lastnameTeController.text.trim(),
        mobile: _mobileTeController.text.trim(),
      );
      await AuthController.saveUserData(userModel);
      if (mounted) {
        SuccesTost('Profile Updated');
      }
    } else {
      if (mounted) {
       ErrorTost('Error 404! Profile not updated');
      }
    }
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }


  Future<void> _pickProfileImage() async {
    final imagePicker = ImagePicker();
    final XFile? result =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      _selectImage = result;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _emailTeController.dispose();
    _passwordTeController.dispose();
    _mobileTeController.dispose();
    _firstnameTeController.dispose();
    _lastnameTeController.dispose();
    super.dispose();
  }
}
