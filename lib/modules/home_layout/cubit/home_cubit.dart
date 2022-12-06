
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_data_model/categories_model.dart';
import 'package:shopapp/models/favorites_data_model/favorites_model.dart';
import 'package:shopapp/models/get_favorits_model/get_favorite-model.dart';
import 'package:shopapp/models/home_data_model/home_model.dart';
import 'package:shopapp/models/search_model/search_model.dart';
import 'package:shopapp/modules/favourite/favourite_screan.dart';
import 'package:shopapp/modules/home_layout/cubit/home_states.dart';
import 'package:shopapp/modules/home_layout/home_layout.dart';
import 'package:shopapp/modules/products/products_Screan.dart';
import 'package:shopapp/network/remot/dio_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/conestantes/conestantes.dart';

import '../../../network/end_points.dart';
import '../../categories/categories_screan.dart';
import '../../setting/setting.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> screans=[
    ProductsScrean(),
    FavouriteScrean(),
    CatigoriesScrean(),
    SettingScrean(),
  ];
  void changeCurrentIndex(int index){
    currentIndex=index;
    emit(ChangeButNavBarState());
  }

  HomeModel model;
  Map<int ,bool>favoritProduct={};

  void getHomeData(){
    emit(HomeLodingState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      model=HomeModel.fromjason(value.data);
      model.data.products.forEach((element) {
        favoritProduct.addAll({
          element.id:element.in_favorites
        });
      });
      print(favoritProduct.toString());
      emit(HomeSaccesseState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(HomeErerrState(erorr.toString()));
    });
  }

  CategoriesModel c_model;

  void getCategoriesData(){
    emit(CategoriesLodingState());
    DioHelper.getData(url: CATEGORIES,token: token).then((value) {
      c_model=CategoriesModel.fromJson(value.data);
      emit(CategoriesSaccesseState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(CategoriesErerrState(erorr.toString()));
    });
  }

  FavoriteModel fav_model;

  void changeFavoritProduct(int id){
    favoritProduct[id]=!favoritProduct[id];
    emit(FavoriteSaccesseState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':id,
        },
        token: token
    ).then((value) {
      fav_model=FavoriteModel.formJson(value.data);
      print(fav_model.message.toString());
      if(!fav_model.status){
        favoritProduct[id]=!favoritProduct[id];
      }else{
        getFaveroiteData();
      }

      emit(FavoriteSaccesseState());
    }).catchError((erorr){
      favoritProduct[id]=!favoritProduct[id];
      emit(FavoriteErerrState());
    });
  }


  GetFavoritesModel getFav_model;

  void getFaveroiteData(){
    emit(GetFavoriteLodingState());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      getFav_model=GetFavoritesModel.fromJson(value.data);
      print(getFav_model.data.data.toString());
      emit(GetFavoriteSaccesseState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(GetFavoriteErerrState());
    });
  }





}