import 'package:testing/domain/models/profile_model.dart';

abstract class ProfileState {}

class Profileinitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  ProfileSuccess(this.profileModel);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
