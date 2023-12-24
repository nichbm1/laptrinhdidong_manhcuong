import 'package:app_sv/model/place.dart';
import 'package:app_sv/repositories/place_repository.dart';
import 'package:flutter/foundation.dart';

class AddressModel with ChangeNotifier {
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];

  int curCityId = 0;
  int curDistrictId = 0;
  int curWardId = 0;
  String address = "";
  Future<void> initialize(int cityId, int districtId, int wardId) async {
    curCityId = cityId;
    curDistrictId = districtId;
    curWardId = wardId;
    final repo = PlaceRepository();
    listCity = await repo.getListCity();
    if (curCityId != 0) {
      listDistrict = await repo.getListDistrict(curCityId);
    }
    if (curDistrictId != 0) {
      listWard = await repo.getListWard(curDistrictId);
    }
  }

  Future<void> setCity(int cityId) async {
    if (cityId != curCityId) {
      curCityId = cityId;
      curDistrictId = 0;
      curWardId = 0;
      final repo = PlaceRepository();
      listDistrict = await repo.getListDistrict(curCityId);
      listWard.clear();
    }
  }

  Future<void> setDistrict(int districtId) async {
    if (districtId != curDistrictId) {
      curDistrictId = districtId;
      curWardId = 0;
      final repo = PlaceRepository();
      listWard = await repo.getListWard(curDistrictId);
    }
  }

  Future<void> setWard(int wardId) async {
    if (wardId != curWardId) {
      curWardId = wardId;
    }
  }
}
