
import 'package:shopapp/models/login_data_model/login_model.dart';

abstract class LoginStates{}

class LogininitialState extends LoginStates{}

class LoginLodingState extends LoginStates{}

class LoginSaccessState extends LoginStates{
  final LoginModle model;
  LoginSaccessState(this.model);

}

class LoginErorrState extends LoginStates{
  final String erorr;
  LoginErorrState(this.erorr);

}


class LogoutLodingState extends LoginStates{}

class LogoutSaccessState extends LoginStates{}

class LogoutErorrState extends LoginStates{
  final String erorr;
  LogoutErorrState(this.erorr);

}

class ChangePasswordVisibltyState extends LoginStates{}