abstract class RegencyEvent {}

class OnGetRegency extends RegencyEvent {
  String provinceId;

  OnGetRegency(this.provinceId);
}
