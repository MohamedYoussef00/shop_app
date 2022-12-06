
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/register/cubit/register_states.dart';


import '../../../models/login_data_model/login_model.dart';
import '../../../network/end_points.dart';
import '../../../network/remot/dio_helper.dart';
import '../../../shared/conestantes/conestantes.dart';


class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(RegisterinitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  LoginModle userRegisterModel;

  void userRegister({
    @required String userName,
    @required String userEmail,
    @required String password,
    @required String phone,
}){
    emit(RegisterLodingState());
    DioHelper.postData(
        url: REGISTER,
        data:{

          'name':'$userName',
          'email': '$userEmail',
          'password':'$password',
          'phone' : '$phone'
        }
        ).then((value){
          print(value.data);
          userRegisterModel=LoginModle.Fromjson(value.data);
          token=userRegisterModel.data.token;
          emit(RegisterSaccessState(userRegisterModel));
        }
        ).catchError((error){
          emit(RegisterErorrState(error.toString()));
        }
    );
  }



  IconData suffixIcon=Icons.visibility;
  bool isPassword=true;

  void changeRegisterPasswordVisibilty(){
    isPassword=!isPassword;
    isPassword? suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(ChangePasswordVisibltyState());
  }

}

