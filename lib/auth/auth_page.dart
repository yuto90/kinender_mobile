import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'signup_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, // 影を非表示
        leading: Container(), // 戻るボタンを非表示
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light, // ステータスバー白黒反転
        title: Text(
          'Welcome',
          style: TextStyle(
            color: Color(0xFF42b983),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/event.png',
                width: size.width * 1,
              ),
              ButtonTheme(
                minWidth: size.width * 0.8,
                height: size.width * 0.15,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text('Login'),
                  shape: StadiumBorder(),
                  color: Color(0xFF42b983),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                width: size.width * 0.1,
                height: size.width * 0.07,
              ),
              ButtonTheme(
                minWidth: size.width * 0.8,
                height: size.width * 0.15,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text('Sign up'),
                  shape: StadiumBorder(),
                  color: Colors.green[100],
                  textColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
