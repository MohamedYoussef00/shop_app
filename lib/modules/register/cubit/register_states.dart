
import 'package:shopapp/models/login_data_model/login_model.dart';

abstract class RegisterStates{}

class RegisterinitialState extends RegisterStates{}

class RegisterLodingState extends RegisterStates{}

class RegisterSaccessState extends RegisterStates{
  final LoginModle model;
  RegisterSaccessState(this.model);

}

class RegisterErorrState extends RegisterStates{
  final String erorr;
  RegisterErorrState(this.erorr);

}


class ChangePasswordVisibltyState extends RegisterStates{}