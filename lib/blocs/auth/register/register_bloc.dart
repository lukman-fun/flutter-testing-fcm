import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/auth/register/register_event.dart';
import 'package:testing/blocs/auth/register/register_state.dart';
import 'package:testing/domain/repositories/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnSignupRegister>(_mapSignup);
  }

  _mapSignup(event, emit) async {
    emit(RegisterLoading());
    try {
      final data = await AuthRepository().register(event.body);
      emit(RegisterSuccess(data));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
