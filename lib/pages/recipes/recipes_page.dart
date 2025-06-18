import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recipeapp/pages/recipes/see_more_recipes_page.dart';
import 'package:recipeapp/pages/recipes/widgets/popular_recipes.dart';
import 'package:recipeapp/pages/recipes/widgets/recipes_categories.dart';
import 'package:recipeapp/pages/recipes/widgets/recipes_search_bar.dart';
import 'package:recipeapp/pages/recipes/widgets/recommended_recipes.dart';
import 'package:recipeapp/providers/random_recipes_provider.dart';

class RecipesPage extends ConsumerWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Xin chào", style: theme.textTheme.bodyLarge),
            
          ],
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(randomRecipesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const RecipesSearchBar(),
            Text(
              "Danh mục",
              style: theme.textTheme.titleLarge,
            ),
            const RecipesCategories(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đề xuất cho bạn",
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SeeMoreRecipesPage()));
                    },
                    child: const Text("Xem thêm"))
              ],
            ),
            const RecommendedRecipes(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Công thức của tuần",
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SeeMoreRecipesPage()));
                  },
                  child: const Text("Xem thêm"),
                )
              ],
            ),
            const PopularRecipes()
          ],
        ),
      ),
    );
  }
}
