import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utilitys/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTeController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailTeController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.login),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot password?'),
                        ),
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
                                recognizer: TapGestureRecognizer()..onTap=(){}
                              ),
                            ],
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _emailTeController.dispose();
    _passwordTeController.dispose();
    super.dispose();
  }
}
