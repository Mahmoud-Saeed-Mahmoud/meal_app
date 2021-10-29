import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {

static const routeName = 'category_meals';


  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  
  // ignore: unused_element
  void _removeMeal(String mealId){
    setState(() {
      categoryMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  String? catTitle;
  List<Meal>? categoryMeals;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context,listen: true).availableMeals;
    final routeArg = ModalRoute.of(context)!.settings.arguments as Map<String,String>;
    final catId = routeArg['id']!;
    catTitle = routeArg['title']!;
    categoryMeals = availableMeals.where((meal) {
    return meal.categories.contains(catId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle!),
      ),
      body: GridView.builder(
        itemBuilder: (ctx , index){
          return MealItem(
            id: categoryMeals![index].id,
            imageUrl: categoryMeals![index].imageUrl,
            title: categoryMeals![index].title,
            duration: categoryMeals![index].duration,
            complexity: categoryMeals![index].complexity,
            affordability: categoryMeals![index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: categoryMeals!.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 2.4/2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          ),
      ),
    );
  }
}