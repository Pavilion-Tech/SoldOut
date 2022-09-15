abstract class AuthStates {}

class InitState extends AuthStates {}

class JustEmitState extends AuthStates {}
class LoginLoadingState extends AuthStates {}


class LoginSuccessState extends AuthStates {}

class LoginWrongState extends AuthStates {}

class LoginErrorState extends AuthStates {
  String msg;
  LoginErrorState(this.msg);
}
class SignLoadingState extends AuthStates {}

class SignSuccessState extends AuthStates {}

class SignWrongState extends AuthStates {}

class SignErrorState extends AuthStates {
  String msg;
  SignErrorState(this.msg);
}

class GetCodeSuccessState extends AuthStates {}

class GetCodeErrorState extends AuthStates {
  String msg;
  GetCodeErrorState(this.msg);
}

class SignOutLoadingState extends AuthStates {}

class UpdateProfileLoadingState extends AuthStates {}

class UpdateProfileSuccessState extends AuthStates {}

class UpdateProfileWrongState extends AuthStates {}

class UpdateProfileErrorState extends AuthStates {}

class GetProfileLoadingState extends AuthStates {}

class GetProfileSuccessState extends AuthStates {}

class GetProfileWrongState extends AuthStates {}

class GetProfileErrorState extends AuthStates {}
