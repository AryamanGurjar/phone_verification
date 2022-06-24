/*
This projected is created by me 🐧 (Aryaman a Computer Science Engineer at IIIT Surat)
email = aryamangurjar6@gmail.com

Work:
-----
It sends an otp to the user for Phone Number verification
==================================================================

Working: 
---------
It collects the user entered Phone number and generate a random otp which is then store in 000webhost database.
when verifyotp method is called, it then check 🧐 the entered otp with the otp for that number in database it they match OTP is verified Successfully 😃.

Contributor:
------------
I will be very hapy if yu make this project more advanced and error free 😄.        
*/


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'constants.dart';



class PhoneVerification {
  PhoneVerification({required this.number});
//make sure number should not contain +91 and currently this package only works on Indian Phone Number
//example 
//number = +919647812350(not allowed)
//number = 9647812350( allowed)
  final Telephony telephony = Telephony.instance;//this package is dependent on telephony and http package
  final String number;//number should not be null
  sendotp(String? message) async {
    int otp = 0;
    for (var i = 0; i < 4; i++) {
      otp = otp * 10 + (Random().nextInt(9) + 1);//4 digit otp
    }
    try {
      var res = await http.post(Uri.parse(url_sendotp),
          body: {'number': number, 'otp': otp.toString()});//storing the number and otp in the database
      String finalmessage =
          (message == null ? '' : message) + ' ' + otp.toString();
      var data = await jsonDecode(res.body);
      if (res.statusCode == 200 ||
          data.toString() == 'Success_1' ||
          data.toString() == 'Success_2') {
        telephony.sendSms(to: number, message: finalmessage);//sending automatic sms
      } else {
        if (kDebugMode) {
          print(res.statusCode.toString() + data.toString());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> verifyotp(String enteredotp) async {
    try {
      var res =
          await http.post(Uri.parse(url_receiveotp), body: {'number': number});//collecting otp for the given number
      if (res.statusCode == 200) {
        var data = await jsonDecode(res.body);
        if (data[0]['otp_string'].toString() == enteredotp) {//checking otp
          if (kDebugMode) {
            print('Otp Verified 👍');
          }

          await http.post(Uri.parse(url_verification_complete),//creating space so that the limited database should be utilise properly 
              body: {'number': number});

          return true;
        } else {
          if (kDebugMode) {
            print('Otp Not Verified 👎');
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print(res.statusCode.toString() + 'Error');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
