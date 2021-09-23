import 'package:flutter_appaa/models/shop_app/change_favorite_model.dart';
import 'package:flutter_appaa/models/shop_app/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoriteState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}
class ShopChangeFavoriteState extends ShopStates{}
class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{}
class ShopErrorGetUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
 final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}
