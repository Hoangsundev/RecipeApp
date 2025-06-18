import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/complete_recipe.dart';
import '../utils/network.dart';

part 'search_recipes_provider.g.dart';

@riverpod
Future<List<CompleteRecipe>> searchRecipes(SearchRecipesRef ref, String query) async {
  final url = "https://themealdb.com/api/json/v1/1/search.php?s=$query";
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data['meals'];
      // Kiểm tra nếu data là null, trả về danh sách rỗng
      if (data == null) {
        return [];
      }
      return List.from(data).map((e) => CompleteRecipe.fromMap(e)).toList();
    }
    return [];
  } catch (e) {
    // Xử lý lỗi mạng hoặc khác
    return [];
  }
}