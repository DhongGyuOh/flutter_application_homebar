import 'package:flutter/material.dart';

import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static String routeName = "signup";
  static String routeURL = "/signup";
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(
                -DeviceSize.deviceWidth / 5, -DeviceSize.deviceHeight / 30),
            child: const Text(
              "소셜 로그인으로\n이용이\n가능합니다.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SocialSignUpButton(
            bgColor: Colors.lightGreen,
            textColor: Colors.white,
            iconColor: Colors.white,
            btnText: "네이버로 시작하기",
            btnIcon: FontAwesomeIcons.n,
          ),
          const SocialSignUpButton(
            bgColor: Colors.red,
            textColor: Colors.white,
            iconColor: Colors.white,
            btnText: "Google로 시작하기",
            btnIcon: FontAwesomeIcons.googlePlusG,
          ),
          const SocialSignUpButton(
            bgColor: Colors.yellow,
            textColor: Colors.purple,
            iconColor: Colors.purple,
            btnText: "카카오로 시작하기",
            btnIcon: FontAwesomeIcons.solidComment,
          ),
          const SocialSignUpButton(
            bgColor: Colors.blue,
            textColor: Colors.white,
            iconColor: Colors.white,
            btnText: "페이스북으로 시작하기",
            btnIcon: FontAwesomeIcons.facebookF,
          ),
          const SocialSignUpButton(
            bgColor: Colors.deepPurple,
            textColor: Colors.white,
            iconColor: Colors.white,
            btnText: "깃허브로 시작하기",
            btnIcon: FontAwesomeIcons.github,
          ),
        ],
      ),
    ));
  }
}

class SocialSignUpButton extends ConsumerWidget {
  final MaterialColor bgColor;
  final Color textColor;
  final Color iconColor;
  final String btnText;
  final IconData btnIcon;
  const SocialSignUpButton(
      {super.key,
      required this.bgColor,
      required this.btnText,
      required this.textColor,
      required this.iconColor,
      required this.btnIcon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: DeviceSize.deviceWidth / 1.1,
        height: DeviceSize.deviceHeight / 10,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              btnIcon,
              color: iconColor,
            ),
            Text(
              btnText,
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
