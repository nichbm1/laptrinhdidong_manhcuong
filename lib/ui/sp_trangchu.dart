import 'package:app_sv/provides/mainviewmidel.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:flutter/material.dart';

class SPTrangChu extends StatelessWidget {
  const SPTrangChu({super.key});
  static int idPage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MainViewModel().closeMenu();
      },
      child: Container(
        color: AppConstant.backgroundColor,
        child: Center(
            child: Text(
          "Tin tức",
          style: AppConstant.textHeaderV2,
        )),
      ),
    );
  }
}
