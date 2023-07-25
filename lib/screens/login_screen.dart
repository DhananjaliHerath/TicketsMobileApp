import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert';



import 'package:ticketapp/module/authResponse.dart';
import 'package:ticketapp/screens/home.dart'; 
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  String userName = "";
  String password = "";

 AuthResonse? authResponse;

// UserResponse? userResponse;
  var body = {};
  bool _loading = false;


 void getAuthenticate() async {
  
   setState(() {
      _loading = true;
    });

    body["username"] = userName;
    body["password"] = password;
   String bodyJason = json.encode(body);
   var response = await http.post(
      Uri.parse("http://localhost:8080/authenticate"),
      headers: {"Content-Type": "application/json"},
      body: bodyJason,
    );
       

    print("Login Status Code");
    print(response.statusCode);

     if (response.statusCode == 200) {
     
      authResponse = authResonseFromJson(response.body);

      
      print("User JWT: ${authResponse?.body.jwt}");
      print("User ID: ${authResponse?.body.user.userId}");
      print("User Roles: ${authResponse?.body.user.roles}");
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
      
    } else {
      
      print("Authentication failed. Status code: ${response.statusCode}");
    }

    setState(() {
      _loading = false;
    });
  }
    
  









  Widget  _buildEmailTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Email',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60.0,
        child: TextField(
             onChanged: (value) => {

                userName = value
              },
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: 'Enter your Email',
            hintStyle: TextStyle(
              color: Colors.white54,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    ],
  );
}


 

Widget _buildPasswordTF() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 60.0,
        child: TextField(
           onChanged: (value) => {

                password = value
              },
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your Password',
            hintStyle: TextStyle(
              color: Colors.white54,
              fontFamily: 'OpenSans',
              
            ),
            
          ),
        ),
        
      ),
    ],
  );
}

  

 Widget _buildLoginBtn() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: ElevatedButton(
  onPressed: () {
                            getAuthenticate();

                          
                          },

      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.white,
      ),
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Color(0xFF398AE5),
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}


 
 

  @override

Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
 
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 4.0),
                 
                    Container(
                      height: 320, 
                      
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/login.png', 
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 200, 
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'TICKET SYSTEM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child:  _buildEmailTF(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: _buildPasswordTF(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child:_buildLoginBtn(),
                    ),
                  
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

}
