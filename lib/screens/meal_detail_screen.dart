import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/provider/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';

  Widget buildContainer(Widget child) {
    return Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: child);
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  bool useWhiteForeground(Color color, {double bias: 1.0}) {
    // Old:
    // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

    // New:
    int v = sqrt(pow(color.red, 2) * 0.299 +
            pow(color.green, 2) * 0.587 +
            pow(color.blue, 2) * 0.114)
        .round();
    return v < 130 * bias ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                selectedMeal.title,
                //style: Theme.of(context).textTheme.title,
              ),
              background: Hero(
                tag: mealId,
                child: InteractiveViewer(
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildSectionTitle(context, 'Ingradients'),
                buildContainer(
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (ctx, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(
                            color: useWhiteForeground(
                                    Theme.of(context).colorScheme.secondary)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    itemCount: selectedMeal.ingredients.length,
                  ),
                ),
                buildSectionTitle(context, 'Steps'),
                buildContainer(
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${index + 1}'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              selectedMeal.steps[index],
                              style: TextStyle(
                                color: useWhiteForeground(
                                        Theme.of(context).colorScheme.secondary)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )),
                        Divider(),
                      ],
                    ),
                    itemCount: selectedMeal.steps.length,
                  ),
                ),
                SizedBox(
                  height: 700,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorites(mealId),
        child: Icon(
          Provider.of<MealProvider>(context, listen: true).isMealFavorit(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }
}
