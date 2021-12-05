import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:parihaar_app/Bloc/sign_in_bloc.dart';
import 'package:parihaar_app/Screens/Login%20page/sign_up.dart';
import 'package:parihaar_app/Widgets/Constants/colors.dart';
import 'package:parihaar_app/Widgets/Utilities/rounded_button.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  State<SignInPage> createState() => MySignInPage();
}

class MySignInPage extends State<SignInPage> {
  final bloc = Bloc();
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              const SizedBox(height: 60),

              const Text("Welcome To",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 5),

              Image.asset("assets/images/parihaar logo.png"),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  const Text("Sign in",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 51.0,
                      child: StreamBuilder<String>(
                          stream: bloc.phone,
                          builder: (context, snapshot) {
                            return TextFormField(
                              onChanged: bloc.emailChanged,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  //contentPadding: phoneTextFieldPadding,
                                  prefixIcon: phoneTextFieldPicker(),
                                  focusColor: BlackText,
                                  hintText: "Enter Mobile Number",
                                  hintStyle: const TextStyle(color: GreyText),
                                  errorText: snapshot.error),
                            );
                          }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

               GestureDetector(
                onTap: () {
                  setState(() {
                    pressed = true;
                  });
                },
                child: const Text("Send OTP",
                    style: TextStyle(color: Colors.blue, fontSize: 16)),
              ),

              const SizedBox(height: 15),

              pressed
                  ? Column(
                      children: <Widget>[
                        OtpTextField(
                          numberOfFields: 5,
                          borderColor: BlackText,
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: false,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                        ),
                        const SizedBox(height: 15),
                        const Text("Enter the OTP send to your Mobile Number"),
                      ],
                    )
                  : const SizedBox(),

              const SizedBox(height: 10),

              RoundedButtonHome("Login", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              }),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const Text(
                    "New to Parihaar?",
                    textAlign: TextAlign.center,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text("Sign up",
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


CountryCodePicker phoneTextFieldPicker(){
  return CountryCodePicker(
    initialSelection: '+91',
    favorite: const ['+91', 'IN'],
    textStyle: const TextStyle(color: BlackText),
    showFlag: true,
  );
}
OutlineInputBorder outlineBorder(){
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: BlackText)
  );
}