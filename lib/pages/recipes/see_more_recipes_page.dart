import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipeapp/pages/recipes/recipe_details_page.dart';
import 'package:recipeapp/providers/random_recipes_provider.dart';
import 'package:recipeapp/widgets/recipe_card.dart';

import '../../widgets/spinner.dart';

class SeeMoreRecipesPage extends ConsumerWidget {
  const SeeMoreRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(randomRecipesProvider(30));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm công thức cho bạn"),
      ),
      body: recipes.when(
        data: (data) {
          return RefreshIndicator.adaptive(
            onRefresh: () async => ref.invalidate(randomRecipesProvider(30)),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final recipe = data[index];
                return RecipeCard(
                  id: recipe.id,
                  name: recipe.name,
                  imageUrl: recipe.imageUrl,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailsPage(recipe: recipe)));
                  },
                );
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Lỗi: $error'));
        },
        loading: () {
          return const Center(child: Spinner());
        },
      ),
    );
  }
}
