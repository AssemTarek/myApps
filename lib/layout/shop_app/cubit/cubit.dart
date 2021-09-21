import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appaa/layout/shop_app/cubit/states.dart';
import 'package:flutter_appaa/models/shop_app/categories_model.dart';
import 'package:flutter_appaa/models/shop_app/change_favorite_model.dart';
import 'package:flutter_appaa/models/shop_app/favorite_model.dart';
import 'package:flutter_appaa/models/shop_app/home_model.dart';
import 'package:flutter_appaa/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_appaa/modules/shop_app/favourites/favourites_screen.dart';
import 'package:flutter_appaa/modules/shop_app/products/products_screen.dart';
import 'package:flutter_appaa/modules/shop_app/settings/settings_screen.dart';
import 'package:flutter_appaa/shared/component/constants.dart';
import 'package:flutter_appaa/shared/network/end_points.dart';
import 'package:flutter_appaa/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(
      ShopLoadingHomeDataState(),
    );
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel.data.banners.toString());
      // print (homeModel.status);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      }else
        {
          getFavorites();
        }
      emit(ShopSuccessChangeFavoriteState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoriteState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      lang: 'en',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(ShopErrorGetFavoritesState());
    });
  }
}
