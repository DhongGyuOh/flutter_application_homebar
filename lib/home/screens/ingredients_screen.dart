import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/home/screens/ingredients_vm.dart';
import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IngredientScreen extends ConsumerStatefulWidget {
  static String routeName = "ingredient";
  static String routeURL = "/ingredient";
  const IngredientScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IngredientScreenState();
}

class _IngredientScreenState extends ConsumerState<IngredientScreen> {
  late Future<List<Ingredient>> ingredients;

  @override
  void initState() {
    ingredients = ref.read(ingredientProvider.notifier).getIngredientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ingredients,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                body: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final ingredient = snapshot.data![index];
                    return ListTile(
                      title:
                          Text('${ingredient.ingredientId}.${ingredient.name}'),
                      subtitle: Text(ingredient.detail),
                    );
                  },
                ),
              );
      },
    );
  }
}
