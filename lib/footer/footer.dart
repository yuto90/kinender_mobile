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
