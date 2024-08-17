import 'package:get/get.dart';

import '../../data/model/login_model.dart';
import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/custom_tost_massage.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _signInApiInProgress = false;

  bool get singInApiInProgress => _signInApiInProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSucces = false;
    _signInApiInProgress = true;
    update();

    Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestData);
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);

      SuccesTost('Loged In');
      isSucces=true;
    } else {
      // ErrorTost('Email/password is not correct. Try again');
      isSucces=false;
    }
    _signInApiInProgress = false;
    update();
    return isSucces;
  }
}
