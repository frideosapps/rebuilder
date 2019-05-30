import 'package:flutter/material.dart';

import 'package:rebuilder/rebuilder.dart';

import '../datamodels/app_data.dart';

import '../models/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    final appModel = DataModelProvider.of<AppModel>(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Choose a theme:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            DropdownButton<String>(
              value: appModel.chosenTheme.value,
              items: [
                for (var theme in themes.keys)
                  DropdownMenuItem<String>(
                    value: theme,
                    child: Text(theme, style: const TextStyle(fontSize: 14.0)),
                  )
              ],
              onChanged: appModel.changeTheme,
            ),
          ],
        ),
      ),
    );
  }
}
