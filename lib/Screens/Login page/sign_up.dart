import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:parihaar_app/Bloc/sign_in_bloc.dart';
import 'package:parihaar_app/Screens/Login%20page/login_page.dart';
import 'package:parihaar_app/Widgets/Constants/colors.dart';
import 'package:parihaar_app/Widgets/Utilities/rounded_button.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MySignUp();
}

class MySignUp extends State<SignUp> {
  final bloc = Bloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            const Text("New to Parihaar?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 0),
            Image.asset("assets/images/parihaar logo.png"),
            const SizedBox(height: 0),
            const Text("Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20) ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
            const SizedBox(height: 30),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration:const InputDecoration(
                  focusColor: BlackText,
                  hintText: "12 digit Aadhar Number",
                  hintStyle:  TextStyle(color: GreyText),
                ),
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OtpVarification()));
        },
        child: const Icon(Icons.arrow_forward),
        backgroundColor: ThemeColor,
      ),
    );
  }
}

class OtpVarification extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       children: <Widget>[
         const SizedBox(height: 100),
         Image.asset("assets/images/parihaar logo.png"),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: const Text("An OTP \nhas been send to your Mobile Number",
               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)
           ),
         ),

         const SizedBox(height: 30),

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

         const SizedBox(height: 30),

         const Text("Enter the OTP"),

       ],
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => PersonalDetails()));
       },
       child: const Icon(Icons.arrow_forward),
       backgroundColor: ThemeColor,
     ),
   );
  }
}

class PersonalDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),

          Image.asset("assets/images/parihaar logo.png"),

          const Text("Personal Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              focusColor: BlackText,
              hintText: "First Name",
              hintStyle: const TextStyle(color: GreyText),
             ),
        ),
      ),
          const SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusColor: BlackText,
                hintText: "Last Name",
                hintStyle: const TextStyle(color: GreyText),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: dateFieldDecoration(),
              readOnly: true,
              onTap: () async {
                DateTime pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101)
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          RoundedButtonHome("Sign Up", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          }),
        ],
      ),
    );
  }
}

InputDecoration dateFieldDecoration(){
  return const InputDecoration(
    filled: false,
    suffixIcon: Icon(Icons.calendar_today,color: BlackText),
    hintText: "Date of Birth",
    hintStyle: const TextStyle(color: GreyText),
  );
}
