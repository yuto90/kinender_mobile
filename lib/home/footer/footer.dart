import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:kinender_mobile/home/home_model.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // providerからデータ受け取り
    int currentIndex = context.watch<int>();
    Function changeColor = context.watch<Function>();

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0.0, // footerの影を無くす
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF42b983), // 選択中アイテムの色
      unselectedItemColor: Colors.grey, // 非選択のアイテムの色
      //backgroundColor: Colors.lightBlue,
      //type: BottomNavigationBarType.fixed,
      onTap: (index) {
        changeColor(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '設定',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'マイページ',
        ),
      ],
    );
  }
}
