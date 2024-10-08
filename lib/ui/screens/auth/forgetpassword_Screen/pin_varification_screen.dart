import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/forgetpassword_Screen/set_password.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';

import '../../../../data/model/network_response.dart';
import '../../../../data/network_caller/network_caller.dart';
import '../../../../data/utilities/urls.dart';
import '../../../widgets/custom_tost_massage.dart';

class PinVarificationScreen extends StatefulWidget {
  const PinVarificationScreen({super.key, required this.email});
  final String email;

  @override
  State<PinVarificationScreen> createState() => _PinVarificationScreenState();
}

class _PinVarificationScreenState extends State<PinVarificationScreen> {
  final TextEditingController _pinTeController = TextEditingController();
  bool _pinVarificationInProgress=false;



  @override
  Widget build(BuildContext context) {
    double heightOfScreen=MediaQuery.of(context).size.height;
    double fontSizedBox= 0.15*heightOfScreen;
    return Scaffold(

      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: fontSizedBox),
                  Text(
                    'Pin Varification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits verification code will send to your e-mail adress',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 16,),
                  PinCodeTextField(
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _pinTeController,

                     appContext: context,
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: _pinVarificationInProgress==false,
                    replacement: CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed:(){
                        _verifyPin(_pinTeController.text);
                      },
                      child: Text('Verify'),
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


  Future<void> _verifyPin(otp) async {
    _pinVarificationInProgress=true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.verifyOtp(widget.email, otp));
    _pinVarificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        _onTapSetPassword(otp);
        SuccesTost('Set Password');
      }
    } else if(response.isSuccess) {
      ErrorTost("Wrong Pin");
    }
  }

  void _onTapBackToSignupPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ), (Route<dynamic> route) => false,
    );
  }

  void _onTapSetPassword(String otp){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SetPassword(email: widget.email,otp: otp,),
      ),
    );
  }

  @override
  void dispose() {
    _pinTeController.dispose();
    super.dispose();
  }







}
