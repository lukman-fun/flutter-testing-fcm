abstract class DistrictEvent {}

class OnGetDistrict extends DistrictEvent {
  String regencyId;

  OnGetDistrict(this.regencyId);
}
