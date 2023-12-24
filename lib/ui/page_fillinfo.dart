import 'package:app_sv/model/profile.dart';
import 'package:app_sv/model/studyclass.dart';
import 'package:app_sv/repositories/student_repository.dart';
import 'package:app_sv/repositories/studyclass_repository.dart';
import 'package:app_sv/repositories/user_repository.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:app_sv/ui/page_main.dart';
import 'package:flutter/material.dart';

class PageFillInfo extends StatefulWidget {
  const PageFillInfo({super.key});

  @override
  State<PageFillInfo> createState() => _PageFillInfoState();
}

class _PageFillInfoState extends State<PageFillInfo> {
  List<StudyClass>? listClass = [];
  Profile profile = Profile();
  String msSV = "";
  String hoTen = "";
  int idLop = 0;
  String tenLop = "";

  @override
  void initState() {
    msSV = profile.student.msSV;
    hoTen = profile.user.firstname;
    idLop = profile.student.idLop;
    tenLop = profile.student.tenLop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const AppLogo(),
              Text(
                "Complete Your Info",
                style: AppConstant.textHeader,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You must fill the correct information, it can't be change!",
                style: AppConstant.textError,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInfoFill(
                title: "Ho Ten",
                value: hoTen,
                width: size.width,
                callBack: (output) {
                  hoTen = output;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInfoFill(
                title: "Ma Sinh Vien",
                value: msSV,
                width: size.width,
                callBack: (output) {
                  msSV = output;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              listClass!.isEmpty
                  ? FutureBuilder(
                      future: StudyClassRepository().getListClass(),
                      builder:
                          (context, AsyncSnapshot<List<StudyClass>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listClass = snapshot.data;
                          return CustomInfoDropDown(
                            list: listClass!,
                            title: "Lop Hoc",
                            valueID: idLop,
                            valueName: tenLop,
                            callBack: ((outputID, outputName) {
                              idLop = outputID;
                              tenLop = outputName;
                            }),
                            width: size.width,
                          );
                        } else {
                          return const Text("Lỗi");
                        }
                      },
                    )
                  : CustomInfoDropDown(
                      list: listClass!,
                      title: "Lop Hoc",
                      valueID: idLop,
                      valueName: tenLop,
                      callBack: ((outputID, outputName) {
                        idLop = outputID;
                        tenLop = outputName;
                      }),
                      width: size.width,
                    ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () async {
                    profile.student.msSV = msSV;
                    profile.student.idLop = idLop;
                    profile.student.tenLop = tenLop;
                    profile.user.firstname = hoTen;
                    await UserRepository().updateProfile();
                    await StudentRepository().registerClass();
                  },
                  child: const CustomButton(textButton: "SAVE INFO")),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, MainPage.routeName);
                  },
                  child: Text(
                    "Back to Home Page",
                    style: AppConstant.textLink,
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
