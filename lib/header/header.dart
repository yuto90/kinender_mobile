import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'header_model.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HeaderModel>(
      create: (_) => HeaderModel(),
      child: Consumer<HeaderModel>(
        builder: (context, model, child) {
          return AppBar(
            title: Text('header'),
          );
        },
      ),
    );
  }
}
