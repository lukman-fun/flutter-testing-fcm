abstract class VillageEvent {}

class OnGetVillage extends VillageEvent {
  String districtId;

  OnGetVillage(this.districtId);
}
