import 'package:app_sv/provides/forgotviewmodel.dart';
import 'package:app_sv/ui/app_constant.dart';
import 'package:app_sv/ui/custom_control.dart';
import 'package:app_sv/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageForgotPassword extends StatelessWidget {
  PageForgotPassword({super.key});
  static String routeName = '/forgot_password';
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: viewmodel.status == 3
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(),
                    Text(
                      "Yêu cầu đã được chấp thuận",
                      style: AppConstant.textHeader,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kiểm tra email",
                      style: AppConstant.textSize18,
                    ),
                    Text(
                      "để đổi mật khẩu!",
                      style: AppConstant.textSize18,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.popAndPushNamed(
                              context, PageLogin.routeName),
                          child: Text(
                            "về trang đăng nhập",
                            style: AppConstant.textLink,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppLogo(),
                        Text(
                          "QUÊN MẬT KHẨU",
                          style: AppConstant.textHeader,
                        ),
                        Text(
                          "Đặt lại mật khẩu ngay",
                          style: AppConstant.textHeaderV2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        viewmodel.status == 2
                            ? Text(
                                viewmodel.errorMessage,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic),
                              )
                            : (const Text("")),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFill(
                          hintText: "nhập địa chỉ email của bạn",
                          textController: _emailController,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            String email = _emailController.text.trim();

                            viewmodel.forgotPassword(email);
                          },
                          child: const CustomButton(
                            textButton: "GỬI YÊU CẦU",
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routeName),
                            child: Text(
                              "đăng nhập ngay",
                              style: AppConstant.textLink,
                            )),
                      ],
                    ),
                    viewmodel.status == 1
                        ? CustomLoading(size: size)
                        : Container(),
                  ],
                ),
        ),
      )),
    );
  }
}
