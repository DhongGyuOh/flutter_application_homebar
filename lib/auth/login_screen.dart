import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_homebar/auth/login_vm.dart';
import 'package:flutter_application_homebar/auth/signup_screen.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailEditingController =
      TextEditingController();
  late final TextEditingController _passwordEditingController =
      TextEditingController();
  String email = "";
  String password = "";

  String? _isEmailValid() {
    email = _emailEditingController.text;
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Sorry, that is not a valid Email Address";
    }
    return null;
  }

  String? _isPasswordValid() {
    if (_passwordEditingController.text.isEmpty) return null;
    return "Check your password";
  }

  @override
  void initState() {
    _emailEditingController.addListener(() {
      setState(() {
        email = _emailEditingController.text;
      });
    });
    _passwordEditingController.addListener(() {
      password = _passwordEditingController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  void _onTapSignUp() async {
    hideKeyboard();
    await Future.delayed(Durations.medium1);
    if (mounted) context.pushNamed(SignUpScreen.routeName);
  }

  void _onTapLogIn() async {
    if (_emailEditingController.text.isEmpty || _isEmailValid() != null) return;
    ref.read(loginProvider.notifier).userLogin(
        _emailEditingController.text, _passwordEditingController.text);
    hideKeyboard();
    await Future.delayed(Durations.medium1);
    if (mounted) context.go("/home");
  }

  void hideKeyboard() async {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailEditingController,
                decoration: InputDecoration(
                    hintText: "Email", errorText: _isEmailValid()),
              ),
              TextFormField(
                controller: _passwordEditingController,
                decoration: InputDecoration(
                    hintText: "Password", errorText: _isPasswordValid()),
                inputFormatters: [
                  //한글 입력 막기
                  FilteringTextInputFormatter.deny(RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]'))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: DeviceSize.deviceWidth,
                child: CupertinoButton(
                  color: Colors.lime,
                  onPressed: _onTapLogIn,
                  child: const Text("Log In"),
                ),
              ),
              CupertinoButton(
                onPressed: _onTapSignUp,
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
