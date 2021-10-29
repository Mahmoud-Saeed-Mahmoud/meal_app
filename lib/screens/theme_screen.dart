import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/main_drawer.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themes';

  const ThemesScreen({Key? key}) : super(key: key);

  ListTile buildListTile(BuildContext context, txt) {
    var priamaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;

    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;

    return ListTile(
      title: Text(
        'Choose Your $txt Color',
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == 'primary' ? priamaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(pickerColor: txt == 'primary' ? 
                  Provider.of<ThemeProvider>(ctx , listen: true).primaryColor:
                  Provider.of<ThemeProvider>(ctx , listen: true).accentColor,
                   onColorChanged: (newColor) => Provider.of<ThemeProvider>(ctx , listen: false).onChanged(newColor, txt == 'primary' ? 1 : 2),
                   colorPickerWidth: 300.0,
                   pickerAreaHeightPercent: 0.7,
                   enableAlpha: true,
                   showLabel: false,
                   ),
                ),
              );
            });
      },
    );
  }

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData? icon, BuildContext context) {
    return RadioListTile(
      secondary: Icon(icon , color: Theme.of(context).iconTheme.color,),
      title: Text(txt),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(context, listen: true).tm,
      onChanged: (newThemeVal) =>
          Provider.of<ThemeProvider>(context, listen: false)
              .themeModeChange(newThemeVal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Themes'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Themes Selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Choose Your Mode',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                    ThemeMode.system, 'System Default Theme', null, context),
                buildRadioListTile(ThemeMode.light, 'Light Theme',
                    Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark, 'Dark Theme',
                    Icons.nights_stay_outlined, context),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent'),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
