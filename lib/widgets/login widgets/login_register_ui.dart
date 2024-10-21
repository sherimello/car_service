import 'package:car_service/business%20logics/firebase_functions.dart';
import 'package:car_service/controllers/loading_controller.dart';
import 'package:car_service/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../general widgets/custom_textfield.dart';
import '../general widgets/loading_overlay.dart';

class LoginRegisterUi extends StatelessWidget {
  const LoginRegisterUi({super.key});

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = LoadingController();
    RxString role = "client".obs;
    var size = Get.size;
    TextEditingController mailController = TextEditingController(),
        passwordController = TextEditingController(),
        phoneController = TextEditingController(),
        nameController = TextEditingController(),
        confirmPasswordController = TextEditingController(),
        roleController = TextEditingController();
    RxBool shouldRememberUser = false.obs, isRegistering = false.obs;

    double getTextHeight(String text, TextStyle style) {
      final textSpan = TextSpan(text: text, style: style);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);
      return textPainter.height;
    }

    return Obx(() => Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.all(27.0),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getTextHeight(
                                "headlights",
                                TextStyle(
                                    height: 0,
                                    fontFamily: "Rounded_Elegance",
                                    fontSize: size.width * .067,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white.withOpacity(.55))) +
                            17,
                      ),
                      CustomTextfield(
                        hint: "abc@gmail.com",
                        controller: mailController,
                        tag: "email address",
                        iconData: CupertinoIcons.mail,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Visibility(
                          visible: isRegistering.value,
                          child: CustomTextfield(
                            hint: "+8801111111111",
                            controller: phoneController,
                            tag: "phone number",
                            iconData: CupertinoIcons.phone_down,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: const SizedBox(
                            height: 11,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: CustomTextfield(
                            hint: "itachi uchiha",
                            controller: nameController,
                            tag: "your full name",
                            iconData: CupertinoIcons.creditcard,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: const SizedBox(
                            height: 11,
                          )),
                      CustomTextfield(
                        hint: "********",
                        controller: passwordController,
                        tag: "passkey",
                        iconData: CupertinoIcons.padlock_solid,
                      ),
                      Visibility(
                          visible: isRegistering.value,
                          child: const SizedBox(
                            height: 11,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: CustomTextfield(
                            hint: "********",
                            controller: confirmPasswordController,
                            tag: "confirm passkey",
                            iconData: CupertinoIcons.padlock_solid,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: const SizedBox(
                            height: 11,
                          )),
                      Visibility(
                          visible: isRegistering.value,
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(21)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            17, 17, 17, 8.5),
                                        child: GestureDetector(
                                          onTap: () {
                                            role.value = "client";
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "client",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "SF-Pro"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            17, 8.5, 17, 17),
                                        child: GestureDetector(
                                          onTap: () {
                                            role.value = "mechanic";
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "mechanic",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "SF-Pro"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                            child: CustomTextfield(
                              enabled: false,
                              hint: role.value,
                              controller: roleController,
                              tag: "register as",
                              iconData: CupertinoIcons.person,
                            ),
                          )),
                      Row(
                        children: [
                          Checkbox(
                            value: shouldRememberUser.value,
                            onChanged: (v) {
                              shouldRememberUser.value = v!;
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            focusColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          const Text(
                            "remember me",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      const Text(
                        "by signing in / registering, you are agreeing to comply with our terms and services.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () {
                          loadingController.updateShouldShowLoadingOverlay();
                          isRegistering.value
                              ? FirebaseFunctions().register(
                                  mailController,
                                  passwordController,
                                  nameController,
                                  phoneController,
                                  role.value,
                                  loadingController).whenComplete(() => Get.to(const Home()))
                              : FirebaseFunctions().signInWithEmailAndPassword(
                                  mailController,
                                  passwordController,
                                  loadingController).whenComplete(() => Get.to(const Home()));
                        },
                        child: Container(
                          width: size.width,
                          height: AppBar().preferredSize.height * .87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              isRegistering.value ? "register" : "sign in",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: isRegistering.value
                                    ? "already have an account? "
                                    : "don't have an account? ",
                                style: const TextStyle(color: Colors.white)),
                            WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => isRegistering.value =
                                      !isRegistering.value,
                                  child: Text(
                                    isRegistering.value
                                        ? "sign in here"
                                        : "register here",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                alignment: PlaceholderAlignment.middle)
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: loadingController.shouldShowLoadingOverlay.value,
                  child: const LoadingOverlay())
            ],
          ),
        ));
  }
}
