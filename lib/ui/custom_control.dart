import 'dart:io';

import 'package:app_sv/model/place.dart';
import 'package:app_sv/model/profile.dart';
import 'package:app_sv/model/studyclass.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomPlaceDropDown extends StatefulWidget {
  const CustomPlaceDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueID,
    required this.callBack,
    required this.list,
    required this.valueName,
  });
  final List<Place> list;
  final double width;
  final String title;
  final int valueID;
  final String valueName;
  final Function(int outputID, String outputName) callBack;
  @override
  State<CustomPlaceDropDown> createState() => _CustomPlaceDropDownState();
}

class _CustomPlaceDropDownState extends State<CustomPlaceDropDown> {
  int status = 0;
  int outputID = 0;
  String outputName = "";
  @override
  void initState() {
    outputID = widget.valueID;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            widget.title,
            style: AppConstant.textFill,
          ),
        ),
        status == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width),
                        ),
                        child: Text(
                          widget.valueName == "" ? "..." : widget.valueName,
                          style: AppConstant.textFillShow,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 1;
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppConstant.backgroundColor,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppConstant.backgroundColor,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const EditIcon()),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              value: widget.valueID,
                              items: widget.list
                                  .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name,
                                        style: AppConstant.textNormal,
                                        overflow: TextOverflow.ellipsis,
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  outputID = value!;
                                  for (var dropitem in widget.list) {
                                    if (dropitem.id == outputID) {
                                      outputName = dropitem.name;
                                      widget.callBack(outputID, outputName);
                                    }
                                  }
                                });
                              }),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppConstant.backgroundColor,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppConstant.backgroundColor,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const SaveIcon()),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class CustomTextFill extends StatelessWidget {
  const CustomTextFill({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppConstant.colorGradient,
              // border: Border.all(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: TextField(
                  obscureText: obscureText,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: AppConstant.textNormal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: AppConstant.colorGradient,
            borderRadius: BorderRadius.circular(100)),
        child: Center(
            child: Text(
          textButton,
          style: AppConstant.textButton,
        )),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.wind_power,
      size: 150,
      color: Colors.blue,
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 300,
          image: AssetImage('assets/images/loading.gif'),
        ),
      ),
    );
  }
}

class SaveIcon extends StatelessWidget {
  const SaveIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.save,
      size: 30,
      color: Colors.blue,
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.edit,
      size: 30,
      color: Colors.blue,
    );
  }
}

// ignore: must_be_immutable
class CustomUploadAvatar extends StatelessWidget {
  XFile? image;
  CustomUploadAvatar({
    super.key,
    required this.size,
    required this.image,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.25),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.file(File(image!.path), fit: BoxFit.fill),
      ),
    );
  }
}

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.25),
      child: SizedBox(
          width: 100,
          height: 100,
          child: Image.network(
            Profile().user.avatar,
            fit: BoxFit.cover,
          )),
    );
  }
}

class CustomInfoDropDown extends StatefulWidget {
  const CustomInfoDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueID,
    required this.callBack,
    required this.list,
    required this.valueName,
  });
  final List<StudyClass> list;
  final double width;
  final String title;
  final int valueID;
  final String valueName;
  final Function(int outputID, String outputName) callBack;
  @override
  State<CustomInfoDropDown> createState() => _CustomInfoDropDownState();
}

class _CustomInfoDropDownState extends State<CustomInfoDropDown> {
  int status = 0;
  int outputID = 0;
  String outputName = "";
  @override
  void initState() {
    outputID = widget.valueID;
    outputName = widget.valueName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            widget.title,
            style: AppConstant.textFill,
          ),
        ),
        status == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width),
                        ),
                        child: Text(
                          outputName == "" ? "..." : outputName,
                          style: AppConstant.textFillShow,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 1;
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const EditIcon()),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              value: outputID,
                              items: widget.list
                                  .map((e) => DropdownMenuItem(
                                      value: e.idLop,
                                      child: Text(
                                        e.tenLop,
                                        style: AppConstant.textNormal,
                                        overflow: TextOverflow.ellipsis,
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  outputID = value!;
                                  for (var dropitem in widget.list) {
                                    if (dropitem.idLop == outputID) {
                                      outputName = dropitem.tenLop;
                                      widget.callBack(outputID, outputName);
                                    }
                                  }
                                });
                              }),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const SaveIcon()),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class CustomInfoFill extends StatefulWidget {
  const CustomInfoFill(
      {super.key,
      required this.width,
      required this.title,
      required this.value,
      required this.callBack,
      this.type = TextInputType.text});

  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callBack;
  @override
  State<CustomInfoFill> createState() => _CustomInfoFillState();
}

class _CustomInfoFillState extends State<CustomInfoFill> {
  int status = 0;
  String output = "";
  @override
  void initState() {
    output = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            widget.title,
            style: AppConstant.textFill,
          ),
        ),
        status == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(widget.width),
                        ),
                        child: Text(
                          widget.value == "" ? "..." : widget.value,
                          style: AppConstant.textFillShow,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 1;
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppConstant.backgroundColor,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppConstant.backgroundColor,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const EditIcon()),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.all(2),
                    width: widget.width * 0.75,
                    decoration: BoxDecoration(
                        gradient: AppConstant.colorGradient,
                        borderRadius: BorderRadius.circular(widget.width)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(widget.width),
                      ),
                      child: TextFormField(
                        keyboardType: widget.type,
                        style: AppConstant.textNormal,
                        initialValue: output,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                            widget.callBack(output);
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        status = 0;
                        widget.callBack(output);
                      });
                    },
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(2),
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppConstant.backgroundColor,
                          borderRadius: BorderRadius.circular(widget.width)),
                      child: Container(
                          alignment: Alignment.center,
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppConstant.backgroundColor,
                            borderRadius: BorderRadius.circular(widget.width),
                          ),
                          child: const SaveIcon()),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
