import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
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
                    bottom: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text('ユーザー設定'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserConfig(),
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
