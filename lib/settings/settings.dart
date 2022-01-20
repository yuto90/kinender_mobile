import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import '../user_check.dart';
import 'settings_model.dart';
import 'user_config/user_config.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsModel>(
      create: (_) => SettingsModel(),
      child: Consumer<SettingsModel>(
        builder: (context, model, child) {
          return ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    bottom: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text('ユーザー情報'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserConfig(),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'ログアウト',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    model.logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserCheck(),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
