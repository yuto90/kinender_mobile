import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import 'footer_model.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FooterModel>(
      create: (_) => FooterModel(),
      child: Consumer<FooterModel>(
        builder: (context, model, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0.0, // footerの影を無くす
            currentIndex: model.currentIndex,
            selectedItemColor: Color(0xFF42b983), // 選択中アイテムの色
            unselectedItemColor: Colors.grey, // 非選択のアイテムの色
            //backgroundColor: Colors.lightBlue,
            //type: BottomNavigationBarType.fixed,
            onTap: (index) {
              model.changeSelectedItemColor();
            },
            items: const [
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
        },
      ),
    );
  }
}
