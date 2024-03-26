import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/auth/signup_screen.dart';
import 'package:flutter_application_homebar/home/home_screen.dart';
import 'package:flutter_application_homebar/navigation_screen.dart';
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
  String? _isEmailValid() {
    return "This is not a valid email format";
  }

  String? _isPasswordValid() {
    return "Check your password";
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
                decoration: InputDecoration(
                    hintText: "Email", errorText: _isEmailValid()),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Password", errorText: _isPasswordValid()),
              ),
              CupertinoButton(
                  child: const Text("Log In"),
                  onPressed: () {
                    context.go("/home");
                  }),
              CupertinoButton(
                  child: const Text("Sign Up"),
                  onPressed: () {
                    context.pushNamed(SignUpScreen.routeName);
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
