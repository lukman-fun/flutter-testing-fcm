import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/auth/profile/profile_event.dart';
import 'package:testing/blocs/auth/profile/profile_state.dart';
import 'package:testing/domain/repositories/auth_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(Profileinitial()) {
    on<OnGetProfile>(_mapGetProfile);
  }

  _mapGetProfile(event, emit) async {
    emit(ProfileLoading());
    try {
      final data = await AuthRepository().profile(event.parentId);

      emit(ProfileSuccess(data));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
