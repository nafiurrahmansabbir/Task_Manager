import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/forgetpassword_Screen/email_varification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/utilitys/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _confirmpasswordTeController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();

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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Maximum length of password 8 character with latter and number',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordTeController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmpasswordTeController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {_onTapSingInButton();},
                    child: Text('Confirm'),
                  ),
                  const SizedBox(
                    height: 36,
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
              text: "Don't have any account?  ",
              children: [
                TextSpan(
                    style: TextStyle(
                      color: AppColors.themeColor,
                    ),
                    text: "Sign Up",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _onTapSingInButton();
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapSingInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ), (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _confirmpasswordTeController.dispose();
    _passwordTeController.dispose();
    super.dispose();
  }
}
