abstract class ProfileEvent {}

class OnGetProfile extends ProfileEvent {
  final String? parentId;

  OnGetProfile(this.parentId);
}
