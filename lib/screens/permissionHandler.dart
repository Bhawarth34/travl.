import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travl/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class permissionHandler extends StatefulWidget{
  final String title;
  const permissionHandler({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _permissionHandler();
}

class _permissionHandler extends State<permissionHandler>{

  Future<bool> _checkPermissions() async{
    List<Permission> permission = [
      Permission.location,
      Permission.storage,
      Permission.contacts,
      Permission.notification,
      Permission.phone,
    ];

    for(Permission per in permission){
      if(await per.isGranted==false){
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){_havePermission();});

  }

  Future<void> _permissionRequester() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.contacts,
      Permission.notification,
      Permission.phone,
    ].request();


    statuses.forEach((permission, status) {
      if(status != PermissionStatus.granted){
        String perm = permission.toString().split(".")[1];
        Fluttertoast.showToast(msg: "Grant $perm permission.");
        openAppSettings();
      }
    });

    if(!context.mounted){
      return;
    }

    _havePermission();
    }


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
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("./lib/assets/permission_Image.png"),
              width: 350,),
            Text("Permissions Needed",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("In order to proceed we require some permissions to provide you better experience.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: _permissionRequester,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  minimumSize: Size(370, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
                child: Text("Grant Permission"),
            )
          ],
        ),
      ),
    ),
    );
  }

  Future<void> _havePermission() async {
    if(await _checkPermissions() && mounted){
      Navigator.pushReplacement(context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation)=>login(title: widget.title,),
              transitionsBuilder: (context, animation, secondaryAnimation, child){
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(position: animation.drive(tween), child: child,);
              }
          )
      );
    }
  }
}