import 'package:app_sv/model/profile.dart';
import 'package:app_sv/provides/mainviewmidel.dart';
import 'package:app_sv/provides/menubarviewmodel.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:app_sv/ui/page_fillinfo.dart';
import 'package:app_sv/ui/page_login.dart';
import 'package:app_sv/ui/sp_course.dart';
import 'package:app_sv/ui/sp_list_r_course.dart';
import 'package:app_sv/ui/sp_list_student.dart';
import 'package:app_sv/ui/sp_profile.dart';
import 'package:app_sv/ui/sp_trangchu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static String routeName = '/home';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> menuTitles = [
    'Trang chủ',
    'Hồ Sơ',
    'Môn Học',
    'Học phần',
    'DSSV',
  ];

  final menuBar = MenuListItem();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return PageLogin();
    }
    if (profile.student.msSV == "") {
      return const PageFillInfo();
    }
    Widget body = const SPTrangChu();
    menuBar.initialize(menuTitles);
    if (viewmodel.activeMenu == SPProfile.idPage) {
      body = SPProfile();
    } else if (viewmodel.activeMenu == SPRegisterCourse.idPage) {
      body = const SPRegisterCourse();
    } else if (viewmodel.activeMenu == SPCourse.idPage) {
      body = const SPCourse();
    } else if (viewmodel.activeMenu == SPListSV.idPage) {
      body = const SPListSV();
    } else if (viewmodel.activeMenu == SPTrangChu.idPage) {
      body = const SPTrangChu();
    }
    return Scaffold(
      appBar: AppBar(
        leadingWidth: size.width,
        leading: Container(
          decoration: BoxDecoration(gradient: AppConstant.colorGradient),
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => viewmodel.toggleMenu(),
                    child: const Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
                GestureDetector(
                  onTap: () {
                    viewmodel.logout();
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return Container(color: Colors.blue, child: Center(child: body));
            },
          ),
          viewmodel.menuStatus == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menuBarModel, child) {
                    return GestureDetector(
                        onPanUpdate: (details) {
                          menuBarModel.setOffset(details.localPosition);
                        },
                        onPanEnd: (details) {
                          menuBarModel.setOffset(const Offset(0, 0));
                          viewmodel.closeMenu();
                        },
                        child: Stack(
                          children: [CustomMenuSideBar(size: size), menuBar],
                        ));
                  },
                )
              : Container()
        ],
      )),
    );
  }
}

class MenuListItem extends StatelessWidget {
  MenuListItem({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
          idPage: i, title: menuTitles[i], containerKey: GlobalKey()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height * 0.3,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.4,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: size.height * 0.16,
                  width: size.height * 0.16,
                  decoration: BoxDecoration(
                    gradient: AppConstant.colorGradient,
                    borderRadius: BorderRadius.circular(size.height),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height),
                        color: Colors.white),
                    child: CustomAvatar(size: size),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[700],
              width: 1,
              height: size.height * 0.225,
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10.0),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuBarItems.length,
                    itemBuilder: (context, index) {
                      return menuBarItems[index];
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerKey,
    required this.idPage,
  });
  final int idPage;
  final String title;
  final GlobalKey containerKey;
  TextStyle style = AppConstant.textBody;

  void onMove(Offset offSet) {
    if (offSet.dy == 0) {
      style = AppConstant.textBody;
    }
    if (containerKey.currentContext != null) {
      RenderBox box =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offSet.dy < position.dy - 40 && offSet.dy > position.dy - 80) {
        style = AppConstant.textBodyFocus;
        MainViewModel().activeMenu = idPage;
      } else {
        style = AppConstant.textBody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onMove(menuBarModel.offSet);
    return GestureDetector(
      onTap: () {
        MainViewModel().setActive(idPage);
      },
      child: Container(
        key: containerKey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenuSideBar extends StatelessWidget {
  const CustomMenuSideBar({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    final sideBarModel = Provider.of<MenuBarViewModel>(context);
    return CustomPaint(
      size: Size(size.width, size.height * 0.3),
      painter: DrawerCustomPaint(offSet: sideBarModel.offSet),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offSet;
  DrawerCustomPaint({super.repaint, required this.offSet});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
