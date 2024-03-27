import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/auth/login_vm.dart';
import 'package:flutter_application_homebar/auth/signup_screen.dart';
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

  String? _isEmailValid() {
    return "This is not a valid email format";
  }

  String? _isPasswordValid() {
    return "Check your password";
  }

  void _onTapSignUp() async {
    hideKeyboard();
    await Future.delayed(Durations.medium1);
    if (mounted) context.pushNamed(SignUpScreen.routeName);
  }

  void _onTapLogIn() async {
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
              ),
              CupertinoButton(
                onPressed: _onTapLogIn,
                child: const Text("Log In"),
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
