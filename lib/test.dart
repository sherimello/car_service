import 'package:car_service/widgets/general%20widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    TextEditingController mailController = TextEditingController();
    RxBool shouldRememberUser = false.obs;

    return Obx(() => Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfield(hint: "abc@gmail.com", controller: mailController, tag: "email address", iconData: CupertinoIcons.mail,),
              const SizedBox(height: 11,),
              CustomTextfield(hint: "********", controller: mailController, tag: "passkey", iconData: CupertinoIcons.padlock_solid,),
              Row(
                children: [
                  Checkbox(value: shouldRememberUser.value, onChanged: (v) {
                    shouldRememberUser.value = v!;
                  },
                  activeColor: Colors.white,
                    checkColor: Colors.black,
                    focusColor: Colors.white,
                    side: const BorderSide(color: Colors.white,),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  const Text(
                    "remember me",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900
                    ),
                  )
                ],
              ),
              const Text(
                "by signing in, you are agreeing to comply with our terms and services.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 17,),
              Container(
                width: size.width,
                height: AppBar().preferredSize.height * .87,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: const Center(
                  child: Text("sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 17,),
              Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "don't have an account? ",
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  WidgetSpan(child: GestureDetector(child: const Text("register here",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w900
                  ),
                  ),),
                  alignment: PlaceholderAlignment.middle
                  )
                ]),
                textAlign: TextAlign.center,),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
