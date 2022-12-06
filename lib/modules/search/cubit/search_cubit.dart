

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/cubit/search_states.dart';

import '../../../models/search_model/search_model.dart';
import '../../../network/end_points.dart';
import '../../../network/remot/dio_helper.dart';
import '../../../shared/conestantes/conestantes.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit():super(SearchinitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel searchModel;

  void getSearchData(String text){
    emit(GetSearchLodingState());
    DioHelper.postData(
        url:SEARCH,
        data: {
          'text':text
        },
        token: token
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);

      emit(GetSearchSaccesseState());
    }).catchError((erorr){
      print(erorr.toString()+'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      emit(GetSearchErerrState());
    }
    );
  }

}

