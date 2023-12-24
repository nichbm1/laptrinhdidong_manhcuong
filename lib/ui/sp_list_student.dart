import 'package:app_sv/model/profile.dart';
import 'package:app_sv/model/studyclass.dart';
import 'package:app_sv/provides/mainviewmidel.dart';
import 'package:app_sv/repositories/studyclass_repository.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:flutter/material.dart';

class SPListSV extends StatefulWidget {
  const SPListSV({super.key});
  static int idPage = 4;

  @override
  State<SPListSV> createState() => _SPListSVState();
}

class _SPListSVState extends State<SPListSV> {
  List<SV>? listStudent = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        MainViewModel().closeMenu();
      },
      child: Container(
          color: AppConstant.backgroundColor,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "DANH SÁCH SINH VIÊN",
                    style: AppConstant.textHeaderV2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: StudyClassRepository()
                        .getStudentList(Profile().student.idLop),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomLoading(size: size);
                      } else if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        listStudent = snapshot.data;
                        return Container(
                          padding: const EdgeInsets.all(10),
                          width: size.width,
                          height: size.height,
                          child: ListView.builder(
                            itemCount: listStudent!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 80,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "Họ Tên: ${listStudent![index].first_name}",
                                    style: AppConstant.textCourseBold,
                                  ),
                                  subtitle: Text(
                                    "MSSV: ${listStudent![index].mssv}",
                                    style: AppConstant.textCourse,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
