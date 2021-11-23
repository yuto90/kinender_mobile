import 'package:flutter/material.dart';
import 'package:kinender_mobile/header/header.dart';
import 'package:provider/provider.dart';
import 'settings_model.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsModel>(
      create: (_) => SettingsModel(),
      child: Consumer<SettingsModel>(
        builder: (context, model, child) {
          return Container(
            child: Text('aaa'),
          );
        },
      ),
    );
  }
}
