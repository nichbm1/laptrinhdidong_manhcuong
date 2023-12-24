import 'package:app_sv/model/course.dart';
import 'package:app_sv/provides/courseviewmodel.dart';
import 'package:app_sv/repositories/course_repository.dart';

import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SPCourse extends StatefulWidget {
  const SPCourse({super.key});
  static int idPage = 3;

  @override
  State<SPCourse> createState() => _SPCourseState();
}

class _SPCourseState extends State<SPCourse> {
  List<Course>? listCourse = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<CourseViewModel>(context);
    return Container(
        width: double.infinity,
        color: AppConstant.backgroundColor,
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(10),
          child: viewmodel.status == 3 || viewmodel.status == 2
              ? Center(
                  child: Column(
                  children: [
                    Text(
                      viewmodel.message,
                      style: AppConstant.textHeaderV2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          viewmodel.resetStatus();
                        },
                        child: const CustomButton(textButton: "OK"))
                  ],
                ))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        Text(
                          "DANH SÁCH HỌC PHẦN",
                          style: AppConstant.textHeaderV2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        listCourse!.isEmpty
                            ? FutureBuilder(
                                future: CourseRepository().getListCourse(),
                                builder: (context,
                                    AsyncSnapshot<List<Course>> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CustomLoading(size: size);
                                  } else if (snapshot.hasError) {
                                    return const Text("Lỗi");
                                  } else {
                                    listCourse = snapshot.data;
                                    return SizedBox(
                                      width: size.width,
                                      height: size.height,
                                      child: ListView.builder(
                                        itemCount: listCourse!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              alignment: Alignment.centerLeft,
                                              height: 140,
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      listCourse![index]
                                                          .tenhocphan,
                                                      style: AppConstant
                                                          .textCourseBold,
                                                    ),
                                                    subtitle: Text(
                                                      "Giảng viên: ${listCourse![index].tengv}",
                                                      style: AppConstant
                                                          .textCourse,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width: double.infinity,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        gradient: AppConstant
                                                            .colorGradient),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        await viewmodel
                                                            .registerCourse(
                                                                listCourse![
                                                                        index]
                                                                    .id);
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    );
                                  }
                                },
                              )
                            : SizedBox(
                                width: size.width,
                                height: size.height,
                                child: ListView.builder(
                                  itemCount: listCourse!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      height: 140,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              listCourse![index].tenhocphan,
                                              style: AppConstant.textCourseBold,
                                            ),
                                            subtitle: Text(
                                              "Giảng viên: ${listCourse![index].tengv}",
                                              style: AppConstant.textCourse,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            width: double.infinity,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                gradient:
                                                    AppConstant.colorGradient),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await viewmodel.registerCourse(
                                                    listCourse![index].id);
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                      ]),
                    ),
                    viewmodel.status == 1
                        ? CustomLoading(size: size)
                        : Container()
                  ],
                ),
        ));
  }
}
