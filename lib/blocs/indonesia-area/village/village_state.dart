import 'package:testing/domain/models/village_model.dart';

abstract class VillageState {}

class VillageInitial extends VillageState {}

class VillageLoading extends VillageState {}

class VillageSuccess extends VillageState {
  final VillageModel villageModel;

  VillageSuccess(this.villageModel);
}

class VillageError extends VillageState {
  final String error;

  VillageError(this.error);
}
