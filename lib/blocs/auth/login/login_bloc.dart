import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/auth/login/login_event.dart';
import 'package:testing/blocs/auth/login/login_state.dart';
import 'package:testing/domain/repositories/auth_repository.dart';
import 'package:testing/utils/session_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogin>(_mapLogin);
  }

  _mapLogin(event, emit) async {
    emit(LoginLoading());
    try {
      final data = await AuthRepository().login(event.body);
      SessionAuth.setAuth(data);
      emit(LoginSuccess(data));
      // emit(LoginInitial());
      print('YOS : ${data.toJson()}');
    } catch (e) {
      print('YOS : ${e.toString()}');
      emit(LoginError(e.toString()));
      // emit(LoginInitial());
    }
  }
}
