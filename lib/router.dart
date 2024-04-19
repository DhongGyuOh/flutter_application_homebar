import 'package:flutter_application_homebar/auth/interest_screen.dart';
import 'package:flutter_application_homebar/auth/login_vm.dart';
import 'package:flutter_application_homebar/auth/signup_screen.dart';
import 'package:flutter_application_homebar/auth/login_screen.dart';
import 'package:flutter_application_homebar/home/screens/ingredients_screen.dart';
import 'package:flutter_application_homebar/home/screens/quiz_screen.dart';
import 'package:flutter_application_homebar/navigation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider((ref) {
  return GoRouter(
    //initialLocation: 시작 URL 따로 위젯을 return 안해도 알아서 작동함 맨 앞에"/"는 필수
    initialLocation: "/home",
    //redirect: state 값에 따라 어느 route로 redirect 시킬지 정함
    redirect: (context, state) {
      final email = ref.watch(loginProvider).email;
      if (email == '') {
        //state.matchedLocation: 현재 위치해있는 URL 경로, 쿼리파라미터 값
        if (state.matchedLocation != LoginScreen.routeURL &&
            state.matchedLocation != SignUpScreen.routeURL) {
          return LoginScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/:tab(home|search|receipt|profile)",
        name: NavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return NavigationScreen(
            tab: tab,
          );
        },
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: InterestScreen.routeName,
        path: InterestScreen.routeURL,
        builder: (context, state) => const InterestScreen(),
      ),
      GoRoute(
        name: QuizScreen.routeName,
        path: QuizScreen.routeURL,
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        name: IngredientScreen.routeName,
        path: IngredientScreen.routeURL,
        builder: (context, state) => const IngredientScreen(),
      )
    ],
  );
});
