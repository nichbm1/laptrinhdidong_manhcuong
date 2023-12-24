import 'package:app_sv/model/place.dart';
import 'package:app_sv/services/api_services.dart';

class PlaceRepository {
  Future<List<City>> getListCity() async {
    List<City> list = [];
    list.add(City(id: 0, name: "--Choice--"));
    var data = await ApiServices().getListCity();
    if (data != null) {
      for (var item in data) {
        var city = City.formJson(item);
        list.add(city);
      }
    }
    return list;
  }

  Future<List<District>> getListDistrict(int id) async {
    List<District> list = [];
    list.add(District(id: 0, name: "--Choice--", level: 0));
    var data = await ApiServices().getListDistrict(id);
    if (data != null) {
      for (var item in data) {
        var district = District.formJson(item);
        list.add(district);
      }
    }
    return list;
  }

  Future<List<Ward>> getListWard(int id) async {
    List<Ward> list = [];
    list.add(Ward(id: 0, name: "--Choice--"));
    var data = await ApiServices().getListWard(id);
    if (data != null) {
      for (var item in data) {
        var ward = Ward.formJson(item);
        list.add(ward);
      }
    }
    return list;
  }
}
