
abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeButNavBarState extends ShopStates{}

class HomeLodingState extends ShopStates{}

class HomeSaccesseState extends ShopStates{}

class HomeErerrState extends ShopStates{
  final String erorr;
  HomeErerrState(this.erorr);

}

class CategoriesLodingState extends ShopStates{}

class CategoriesSaccesseState extends ShopStates{}

class CategoriesErerrState extends ShopStates{
  final String erorr;
  CategoriesErerrState(this.erorr);
}

class FavoriteSaccesseState extends ShopStates{}

class FavoriteErerrState extends ShopStates{}

class GetFavoriteLodingState extends ShopStates{}

class GetFavoriteSaccesseState extends ShopStates{}

class GetFavoriteErerrState extends ShopStates{}




