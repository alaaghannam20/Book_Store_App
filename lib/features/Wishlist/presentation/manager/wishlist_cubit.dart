import 'package:bookstore_app/features/Wishlist/data/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';

class WishlistCubit extends Cubit<List<Products>> {
  WishlistCubit() : super([]) {
    _loadUserFavorites();
  }

  Future<void> _loadUserFavorites() async {
    final email = await SharedPrefsHelper.getData(key: 'user_email') ?? '';
    final favorites = await WishlistRepo.fetchFavorites(email);
    emit(favorites);
  }

  Future<void> _persistFavorites(String email) async {
    await WishlistRepo.storeFavorites(email, state);
  }

  Future<void> updateFavoriteStatus(Products product) async {
    final email = await SharedPrefsHelper.getData(key: 'user_email') ?? '';
    if (email.isEmpty) {
      emit([]); 
      return;
    }

    final currentList = [...state];
    final index = currentList.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      currentList.removeAt(index);
    } else {
      currentList.add(product);
    }

    emit(currentList);
    await _persistFavorites(email);
  }

  bool contains(Products product) {
    return state.any((item) => item.id == product.id);
  }

  Future<void> onUserChanged() async {
    emit([]); 
    await _loadUserFavorites(); 
  }
}
