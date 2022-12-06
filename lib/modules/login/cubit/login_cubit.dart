
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_data_model/login_model.dart';
import 'package:shopapp/modules/login/cubit/login_states.dart';
import 'package:shopapp/modules/login/login-Screan/login_screan.dart';
import 'package:shopapp/network/cach_helper/cach_helper.dart';
import 'package:shopapp/network/end_points.dart';
import 'package:shopapp/network/remot/dio_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/conestantes/conestantes.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LogininitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  LoginModle userLoginModel;

  void userLogin({
    @required String userName,
    @required String password,
}){
    emit(LoginLodingState());
    DioHelper.postData(
        url: LOGIN,
        data:{
          'email':'$userName',
          'password':'$password'
        }
        ).then((value){
          print(value.data);
          userLoginModel=LoginModle.Fromjson(value.data);
          token=userLoginModel.data.token;
          emit(LoginSaccessState(userLoginModel));
        }
        ).catchError((error){
          emit(LoginErorrState(error.toString()));
        }
    );
  }

  void userLogout({
    @required String token,
  }){
    emit(LogoutLodingState());
    DioHelper.postData(
        url: 'logout',
        data:{
          'fcm_token':'$token',
        }
    ).then((value){
      emit(LogoutSaccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(LogoutErorrState(error.toString()));
    }
    );
  }

  void Logout({
    context
}){
    CashHelper.removeData(key: 'token').then((value) {
      if(value){
        navigateToAndFinish(context, LoginScrean());
      }
    });
  }

  IconData suffixIcon=Icons.visibility;
  bool isPassword=true;

  void changePasswordVisibilty(){
    isPassword=!isPassword;
    isPassword? suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(ChangePasswordVisibltyState());
  }

}

