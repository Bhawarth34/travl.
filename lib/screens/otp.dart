import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:travl/screens/startRide.dart';

class otp extends StatelessWidget{
  final String title;
  final String number;

  const otp({super.key, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Theme.of(context).primaryColor,
          ),
        )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromRGBO(255,255,255,1),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("./lib/assets/otp_image.png"),
              width: 270,),
            Text("Mobile Phone Verification",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text("Enter the 4-digit verification code that was sent to $number",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 30,),
            PinCodeTextField(
              appContext: context,
              length: 4,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(15),
                fieldHeight: 70,
                fieldWidth: 60,
                inactiveColor: Colors.grey,
                inactiveFillColor: Colors.grey,
                selectedColor: Colors.grey,
                activeColor: Theme.of(context).primaryColor,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: false,
              onCompleted: (value) {
                print('Opt is: $value');
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                );
                sleep(Duration(seconds: 5));
                Navigator.pushReplacement(context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation)=>startRide(title: title,),
                        transitionsBuilder: (context, animation, secondaryAnimation, child){
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(position: animation.drive(tween), child: child,);
                        }
                    )
                );
              },
            )
          ],
        ),
        ),
      ),
    );
  }
}