import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_model.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  // コンストラクタでデータ受け取り
  bool isReturnButton;
  String title;
  Header({key, required this.isReturnButton, required this.title})
      : super(key: key);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HeaderModel>(
      create: (_) => HeaderModel(),
      child: Consumer<HeaderModel>(
        builder: (context, model, child) {
          return AppBar(
            iconTheme: IconThemeData(color: Color(0xFF42b983)),
            title: Text(
              title,
              style: TextStyle(
                color: Color(0xFF42b983),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0, // appbarの影を無くす
            automaticallyImplyLeading: isReturnButton,
          );
        },
      ),
    );
  }
}
