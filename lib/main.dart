import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/auth/login_vm.dart';
import 'package:flutter_application_homebar/firebase_options.dart';
import 'package:flutter_application_homebar/repos/user_repos.dart';
import 'package:flutter_application_homebar/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //위젯트리 내부 초기화
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final repository = UserRepository(preferences);

  runApp(ProviderScope(
      overrides: [loginProvider.overrideWith(() => LoginViewModel(repository))],
      child: const HomeBar()));
  //ProviderScope: Riverpod 상태 관리를 위해 사용되는 위젯으로 ConsumerWidget, Provider 사용이 가능하게 함
  //ProviderScope가 HomeBar 위젯을 자식 위젯으로 설정하여 상태관리가 가능하게함

  await Firebase.initializeApp(
    //Firebase 초기화하는 소스(firebase_core 설치필요)
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class HomeBar extends ConsumerWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final themeData =
        brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: themeData,
      routerConfig: ref.watch(routeProvider),
    );
  }
}
