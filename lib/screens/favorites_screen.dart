import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal_provider.dart';

import '../widgets/meal_item.dart';

class FavoritesScreens extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
  final List<Meal> favoritesMeals = Provider.of<MealProvider>(context,listen: true).favoritesMeals;

    if(favoritesMeals.isEmpty){
      return Center(
      child: Text('You have no favorites yet - start adding some!',
      style: TextStyle(color: Colors.black),),
    );
    }

    else{
      return ListView.builder(
        itemBuilder: (ctx , index){
          return MealItem(
            id: favoritesMeals[index].id,
            imageUrl: favoritesMeals[index].imageUrl,
            title: favoritesMeals[index].title,
            duration: favoritesMeals[index].duration,
            complexity: favoritesMeals[index].complexity,
            affordability: favoritesMeals[index].affordability,
          );
        },
        itemCount: favoritesMeals.length,
      ) ;
    }
  }
}