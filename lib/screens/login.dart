import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travl/screens/otp.dart';

class login extends StatefulWidget{
  final String title;
  const login({super.key, required this.title});
  @override
  State<StatefulWidget> createState() => _login();

}

class _login extends State<login>{

  final TextEditingController numberInput = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text(widget.title,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('./lib/assets/car_animate.json',
            width: 400,
            fit: BoxFit.contain,
            frameRate: FrameRate(60),),
            Text("We help you travl.",
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 35,),),
            SizedBox(height: 10,),
            Text("Sign up with mobile number to get your code.",
              style: TextStyle(fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 18,),),
            SizedBox(height: 20),
            SizedBox(
              child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone Number",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )),
                  SizedBox(height: 10,),
                  TextField(
                    controller: numberInput,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter mobile number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: (){
            print('hello');
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation)=>otp(title: widget.title, number: numberInput.text,),
                  transitionsBuilder: (context, animation, secondaryAnimation, child){
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    
                    return SlideTransition(position: animation.drive(tween), child: child,);
                  }
            ));
            },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              minimumSize: Size(370, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
          child: Text("Submit"),
        ),
      ),
    );
  }
  
}