import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/forgetpassword_Screen/pin_varification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilitys/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';


class EmailVarificationScreen extends StatefulWidget {
  const EmailVarificationScreen({super.key});

  @override
  State<EmailVarificationScreen> createState() =>
      _EmailVarificationScreenState();
}

class _EmailVarificationScreenState extends State<EmailVarificationScreen> {
  final TextEditingController _emailTeController = TextEditingController();

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
              ElevatedButton(
                onPressed: () {_onTapPinCode();},
                child: Icon(Icons.arrow_forward_ios),
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

  void _onTapBackToSignupPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ), (Route<dynamic> route) => false,
    );
  }

  void _onTapPinCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PinVarificationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTeController.dispose();
    super.dispose();
  }
}
