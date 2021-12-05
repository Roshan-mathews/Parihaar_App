import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';


class Bloc extends Object with Validators implements BaseBloc {
  final _phoneController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();

  Function(String) get emailChanged => _phoneController.sink.add;
  Function(String) get passwordChanged => _otpController.sink.add;

  Stream<String> get phone => _phoneController.stream.transform(phoneValidator);
  Stream<String> get otp => _otpController.stream.transform(otpValidator);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(phone, otp, (p, o) => true);

  submit() {

  }

  @override
  void dispose() {
    _phoneController?.close();
    _otpController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}


//=============================================================================  validators
mixin Validators{

  var phoneValidator = StreamTransformer<String,String>.fromHandlers(

      handleData: (phone,sink){
        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(phone);
        if(phoneValid){
          sink.add(phone);
        }
        else{
          sink.addError("Mobile Number is not valid");
        }
      }
  );

  var otpValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (otp,sink){
        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{5,10}$)').hasMatch(otp);
        if(phoneValid){
          sink.add(otp);
        }else{
          sink.addError("otp length should be greater than 4 and less than 11.");
        }
      }
  );
}

//=============================================================================  bloc provider
class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: Provider) as Provider).bloc;
  }
}