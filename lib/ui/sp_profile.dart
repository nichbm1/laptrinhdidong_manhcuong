import 'package:app_sv/model/profile.dart';
import 'package:app_sv/provides/addressmodel.dart';
import 'package:app_sv/provides/mainviewmidel.dart';
import 'package:app_sv/provides/profileviewmodel.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class SPProfile extends StatelessWidget {
  SPProfile({super.key});
  static int idPage = 1;
  XFile? image;
  Future<void> init(
      AddressModel addressmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();
    if (addressmodel.listCity.isEmpty ||
        addressmodel.curCityId != profile.user.provinceid ||
        addressmodel.curDistrictId != profile.user.districtid ||
        addressmodel.curWardId != profile.user.wardid) {
      viewmodel.startLoading();
      await addressmodel.initialize(profile.user.provinceid,
          profile.user.districtid, profile.user.wardid);
      viewmodel.stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final addressmodel = Provider.of<AddressModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(addressmodel, viewmodel));
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          MainViewModel().closeMenu();
        },
        child: Container(
            color: AppConstant.backgroundColor,
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: profileHeader(size, profile, viewmodel),
                    ),
                    CustomInfoFill(
                      width: size.width,
                      title: "Số điện thoại",
                      value: profile.user.phone,
                      callBack: (output) {
                        profile.user.phone = output;
                        viewmodel.setChange();
                        viewmodel.updateScreen();
                      },
                      type: TextInputType.phone,
                    ),
                    CustomInfoFill(
                      width: size.width,
                      title: "Ngày Sinh",
                      value: profile.user.birthday,
                      callBack: (output) {
                        if (AppConstant.isDate(output)) {
                          profile.user.birthday = output;
                        }
                        viewmodel.setChange();
                        viewmodel.updateScreen();
                      },
                      type: TextInputType.datetime,
                    ),
                    CustomPlaceDropDown(
                        width: size.width,
                        title: "Tỉnh/ Thành Phố",
                        valueID: profile.user.provinceid,
                        callBack: (outputID, outputName) async {
                          viewmodel.startLoading();
                          profile.user.provinceid = outputID;
                          profile.user.provincename = outputName;
                          await addressmodel.setCity(outputID);
                          profile.user.districtid = 0;
                          profile.user.districtname = "";
                          profile.user.wardid = 0;
                          profile.user.wardname = "";
                          viewmodel.setChange();
                          viewmodel.stopLoading();
                        },
                        list: addressmodel.listCity,
                        valueName: profile.user.provincename),
                    CustomPlaceDropDown(
                        width: size.width,
                        title: "Quận/ Huyện",
                        valueID: profile.user.districtid,
                        callBack: (outputID, outputName) async {
                          viewmodel.startLoading();
                          profile.user.districtid = outputID;
                          profile.user.districtname = outputName;
                          await addressmodel.setDistrict(outputID);
                          profile.user.wardid = 0;
                          profile.user.wardname = "";
                          viewmodel.setChange();
                          viewmodel.stopLoading();
                        },
                        list: addressmodel.listDistrict,
                        valueName: profile.user.districtname),
                    CustomPlaceDropDown(
                        width: size.width,
                        title: "Phường/ Xã",
                        valueID: profile.user.wardid,
                        callBack: (outputID, outputName) async {
                          viewmodel.startLoading();
                          profile.user.wardid = outputID;
                          profile.user.wardname = outputName;
                          await addressmodel.setWard(outputID);
                          viewmodel.setChange();
                          viewmodel.stopLoading();
                        },
                        list: addressmodel.listWard,
                        valueName: profile.user.wardname),
                    CustomInfoFill(
                      width: size.width,
                      title: "Địa Chỉ",
                      value: profile.user.address,
                      callBack: (output) {
                        profile.user.address = output;
                        viewmodel.setChange();
                        viewmodel.updateScreen();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: QrImageView(
                          data: '{userid:${profile.user.id}}',
                          version: QrVersions.auto,
                          gapless: false,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    viewmodel.isChange == 1
                        ? GestureDetector(
                            onTap: () {
                              viewmodel.updateProfile();
                            },
                            child: const CustomButton(textButton: "SAVE INFO"))
                        : Container(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                viewmodel.status == 1 ? CustomLoading(size: size) : Container()
              ],
            )),
      ),
    );
  }

  Container profileHeader(
      Size size, Profile profile, ProfileViewModel viewmodel) {
    // ignore: unused_local_variable
    return Container(
      padding: const EdgeInsets.all(2),
      height: size.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: AppConstant.colorGradient,
          borderRadius: BorderRadius.circular(5)),
      child: Container(
        height: size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ),
                      Text(
                        profile.student.diem.toString(),
                        style: AppConstant.textWhiteBold,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            gradient: AppConstant.colorGradient,
                            borderRadius: BorderRadius.circular(size.width)),
                        child: viewmodel.updateAvatar == 1 && image != null
                            ? Stack(
                                children: [
                                  CustomUploadAvatar(size: size, image: image),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: GestureDetector(
                                            onTap: () {
                                              viewmodel.saveAvatar(image!);
                                            },
                                            child: const SaveIcon())),
                                  )
                                ],
                              )
                            : GestureDetector(
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  viewmodel.upAvatar();
                                },
                                child: CustomAvatar(size: size))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.user.firstname,
                      style: AppConstant.textWhiteBold,
                    ),
                    Row(
                      children: [
                        Text(
                          "MaSV: ",
                          style: AppConstant.textWhite,
                        ),
                        Text(
                          profile.student.msSV,
                          style: AppConstant.textWhiteBold,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Lớp: ",
                          style: AppConstant.textWhite,
                        ),
                        Text(
                          profile.student.tenLop.toUpperCase(),
                          style: AppConstant.textWhiteBold,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        profile.student.duyet == 0
                            ? const Icon(
                                Icons.event_busy,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.event_available,
                                color: Colors.green,
                              )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Vai Trò: ",
                          style: AppConstant.textWhite,
                        ),
                        profile.user.roleid == 4
                            ? Text(
                                "Sinh Viên",
                                style: AppConstant.textWhiteBold,
                              )
                            : Text(
                                "Giảng Viên",
                                style: AppConstant.textWhiteBold,
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
