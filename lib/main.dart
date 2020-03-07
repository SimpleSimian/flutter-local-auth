//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  )
);

class MyHomePage extends StatefulWidget
{

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MyHomePage>
{
  String _authorized = "Login with your fingerprint";
  String _authorizationState = "Login with fingerprint";
  bool _canCheckBiometrics;
  LocalAuthentication auth = LocalAuthentication();


  Future<void> _authenticateFingerprints() async
  {
    print("finished");
    bool authenticated;
    try
    {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: "Login to proceed",
        useErrorDialogs: true,
        stickyAuth: true,
        );

    }
    on PlatformException catch(e)
    {
      print(e);
    }

    

  }

  Future<void> _authenticateFace() async
  {

  }

  Future<void>_checkBiometrics() async
  {
    bool canCheckBiometrics;
    try 
    {
      canCheckBiometrics = await auth.canCheckBiometrics;

    } 
    on PlatformException catch (e)
    {
      print(e);
    }
    if(!mounted)
      return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

@override
Widget build(BuildContext context)
{
  return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.white,
    body: Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 400, 
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  //Color.fromRGBO(143, 148, 251, 1),
                  Colors.deepOrange, 
                  Color.fromRGBO(255,165,0,0),
                  ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter

              ),
              image: DecorationImage(
                image: AssetImage('assets/images/appBg.png'),
                fit: BoxFit.fill
              ) 
            ),

            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text("Password Manager", style: TextStyle(color: Colors.deepOrange[50], fontSize: 30, fontWeight: FontWeight.bold),),

                      ) ,
                    ),
                  )

                ],
              )
      
          ),
          Padding( 
            padding: EdgeInsets.all(30),
            child: Column( 
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [ 
                        BoxShadow (  
                        color: Color.fromRGBO(143,148,251,1),
                        blurRadius: 20.0,
                        offset: Offset(0,10),
                       ),
                    ]  
                  ), 
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(1.0), 
                        decoration: BoxDecoration(  
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: InputDecoration(  
                          border: InputBorder.none,
                          hintText: "Enter master password",
                          hintStyle: TextStyle(color: Colors.grey[400],),
                        ),
                        textAlign: TextAlign.center,

                      ),
                    
                  ),
                  //
                  ], 
                  )
                ),
                SizedBox(height: 30,),
                Container( 
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange
                  ),
                  child: Center( 
                    child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                    
                ),
                SizedBox(height: 30,),
                InkWell( 
                  onTap: _authenticateFingerprints,
                  child: Container(
                    height: 50,
                    child: Center( 
                      child: Text(_authorizationState, style: TextStyle(color: Colors.lightBlue[300]),),
                      ),
                  )
                ),
               //FingerprintButton(),
                
              ],
            ) ,

          ),
         
        ],
        ),
        ),
  );
}
}

class FingerprintButton extends StatelessWidget
{
  BuildContext myContext;

  Future<void> _authenticate() async {
   Scaffold.of(myContext).showSnackBar(SnackBar( content: Text("Ya pili") ));
  }
@override
  Widget build(BuildContext context)
  {
    myContext = context;
    return InkWell( 
      onTap: _authenticate,
      child: Container(
        height: 50,
        child: Center( 
          child: Text("login with fingeprint", style: TextStyle(color: Colors.lightBlue[300]),),
          ),
      )
    );
  }
      
        
}
