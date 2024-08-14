import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/auth/forgetpassword_Screen/pin_varification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import 'package:task_manager/ui/widgets/custom_tost_massage.dart';

class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  bool _emailVarificationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits verification code will send to your e-mail adress',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTeController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: _emailVarificationInProgress==false,
                    replacement: CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _verifyEmail(_emailTeController.text);
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  BuildHaveAccountSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget BuildHaveAccountSection() {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
              text: "Have account?  ",
              children: [
                TextSpan(
                    style: TextStyle(
                      color: AppColors.themeColor,
                    ),
                    text: "Sign In",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _onTapBackToSignupPage();
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _verifyEmail(String email) async {
    _emailVarificationInProgress = true;
    setState(() {});
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyEmail(email));
    _emailVarificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        _onTapPinCode(email);
        SuccesTost('Sending OTP ');
      }
    } else {
      ErrorTost("Error Server");
    }
  }

  void _onTapBackToSignupPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void _onTapPinCode(email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PinVarificationScreen(email: email,),
      ),
    );
  }

  @override
  void dispose() {
    _emailTeController.dispose();
    super.dispose();
  }
}
