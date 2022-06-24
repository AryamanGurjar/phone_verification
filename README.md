
# Phone Verification

This package helps the flutter developer to send OTP to the user and verify user's Phone Number.\
⭐It is recommended to use this package with real device and not emulator\
⚠ Currently it only works on Android.



## Features

👉 Free OTP Verification System.\
👉 Reliable\
👉 4 digit OTP



## Demo

😅 I am hide my number due to privacy issue

<img src ='https://user-images.githubusercontent.com/82881082/175380660-fb31f101-c6f1-42e2-b337-33d6af1e87ca.gif' height="500">


## Android
- Inside ```android/app/build.gradle``` file change following sdks


```dart
    compileSdkVersion 31 //change to 31

 

    defaultConfig {
       --------------------------------------
        --------------------------------------
        minSdkVersion 21 //change to 21
        targetSdkVersion 30 //change to 30
        --------------------------------------
        --------------------------------------
    }

```

- Inside ```android/app/src/main/AndroidManifest.xml ``` add the following two lines

```dart
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.mysql_register">
  <!-- add these lines 👇 -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.SEND_SMS" />
 <!-- add these lines 👆 -->
   <application
```
## Installation

* First, add the latest ```phone_verification``` package to your pubspec dependencies.

```dart
dependencies:
  phone_verification: ^0.0.1
```

* Second import package to your file

```dart
import 'package:phone_verification/phone_verification.dart'
```
* Call the Instance of PhoneVerification class

```dart
  PhoneVerification phoneverification = PhoneVerification(number: usernumber);
//here usernumber is the Phone number which is to be verified
```



## Send OTP

👉 In the following codes usernumber should be use without country code and Your Otp is the message I want to send with the OTP, you can change that according to your choice.

```dart
  PhoneVerification phoneverification = PhoneVerification(number:'93514xxxxx' );
  
  phoneverification.sendotp('Your Otp');
```
or
```dart
PhoneVerification(number: '93514xxxxx').sendotp('Your Otp');
```
## Verify OTP
👉 Pass the OTP entered by the user to verifyotp() method here ```enteredotp```is the user typed OTP.
```dart
String check= 'No acion';

ElevatedButton(
 onPressed: () async {
    
     //write the below line to verify
    
     bool verify = await PhoneVerification(number: '93514xxxxx').verifyotp(enteredotp.toString());
    
    //if verified successfully it will return true else return false
    
    if (verify == true) {
         check = 'Verify';
     } 

     else {
         check = 'error';
     }
        },
child: Text("Tap To Verify")),
```
or 

```dart
String check= 'No acion';
 ElevatedButton(
  onPressed: () async {
     //write the below line to verify
    
    PhoneVerification phoneverification = PhoneVerification(number: '93514xxxxx');
     bool verify = await phoneverification.verifyotp(enteredotp.toString());
    
    
     //if verified successfully it will return true else return false
    
     check = verify == true ? 'verify' : 'error';
   }
 child: Text("Tap To Verify")),
```