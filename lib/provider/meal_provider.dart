import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';

import 'package:meal_app/models/meal.dart';

class MealProvider with ChangeNotifier {
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoritesMeals = [];
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<String> prefsId = [];

  List<Category> availableCategories = DUMMY_CATEGORIES;

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) return false;

      if (filters['lactose']! && !meal.isLactoseFree) return false;

      if (filters['vegetarian']! && !meal.isVegetarian) return false;

      if (filters['vegan']! && !meal.isVegan) return false;

      return true;
    }).toList();

    List<Category> ac = [];

    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) 
          if (!ac.any((cat) => cat.id == catId))
          ac.add(cat);
        });
      });
    });

    availableCategories = ac;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']!);
    prefs.setBool('lactose', filters['lactose']!);
    prefs.setBool('vegetarian', filters['vegetarian']!);
    prefs.setBool('vegan', filters['vegan']!);
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    prefsId = prefs.getStringList('prefsId') ?? [];
    for (var mealId in prefsId) {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }

    notifyListeners();
  }

  void toggleFavorites(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex =
        favoritesMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoritesMeals.removeAt(existingIndex);
      prefsId.remove(mealId);
    } else {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsId.add(mealId);
    }
    notifyListeners();

    prefs.setStringList('prefsId', prefsId);
  }

  bool isMealFavorit(String id) {
    return favoritesMeals.any((meal) => meal.id == id);
  }
}
