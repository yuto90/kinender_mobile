import 'package:flutter/material.dart';
import 'package:kinender_mobile/home/home.dart';
import 'package:provider/provider.dart';
import 'auth_page_model.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return ChangeNotifierProvider<AuthPageModel>(
      create: (_) => AuthPageModel(),
      child: Scaffold(
        //appBar: Header(headerWord: 'ログイン'),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0, // 影を非表示
          //leading: Container(), // 戻るボタンを非表示
          iconTheme: IconThemeData(
            color: Color(0xFF42b983),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light, // ステータスバー白黒反転
          title: Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF42b983),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Consumer<AuthPageModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomSpace),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/signup.png',
                            width: size.width * 1,
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                            height: size.width * 0.07,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'ユーザー名',
                            ),
                            controller: model.nameController,
                            onChanged: (text) {
                              model.name = text;
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                            height: size.width * 0.07,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'メールアドレス',
                            ),
                            controller: model.emailController,
                            onChanged: (text) {
                              model.email = text;
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                            height: size.width * 0.07,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'パスワード',
                            ),
                            obscureText: true,
                            controller: model.passwordController,
                            onChanged: (text) {
                              model.password = text;
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                            height: size.width * 0.07,
                          ),
                          ButtonTheme(
                            minWidth: size.width * 0.8,
                            height: size.width * 0.15,
                            child: RaisedButton(
                              onPressed: () async {
                                try {
                                  await model.signUp();
                                  print('登録しました');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(e.toString()),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text('Sign Up'),
                              shape: StadiumBorder(),
                              color: Color(0xFF42b983),
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
