import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/provider/theme_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (context) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var priamaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentyColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.black,
              ),
              headline6: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        cardColor: Colors.white,
        shadowColor: Colors.white60,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black87,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: priamaryColor)
            .copyWith(secondary: accentyColor),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(255, 254, 229, 1),
              ),
              headline6: TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        unselectedWidgetColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: priamaryColor)
            .copyWith(secondary: accentyColor),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      //home: CategoryScreen(),
      routes: {
        '/': (context) => TabsScreens(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays ([]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal App'),
      ),
      body: null, //CategoryScreen(),
    );
  }
}
