import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildLisTile(
      String title, IconData iconData, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
        color: Theme.of(ctx).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          color: Theme.of(ctx).textTheme.bodyText1!.color,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Cooking APP',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildLisTile('Meal', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }, context),
          buildLisTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }, context),
          buildLisTile('Themes', Icons.color_lens, () {
            Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName);
          }, context)
        ],
      ),
    );
  }
}
