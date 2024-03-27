import 'package:flutter_application_homebar/models/users.dart';
import 'package:flutter_application_homebar/repos/user_repos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = NotifierProvider<LoginViewModel, User>(
  //LoginViewModel()은 UserRepository를 인자로 갖는데 이 부분을 여기서 넣지못하고
  // main.dart에서 처리함
  () => throw UnimplementedError(),
);

class LoginViewModel extends Notifier<User> {
  final UserRepository _userRepository;
  LoginViewModel(this._userRepository);

  void userLogin(String email, String password) {
    _userRepository.setUser(email, password);
    //state가 변경되면 UI가 자동으로 이를 반영하기 때문에 변경사항을 state에 업데이트해줌
    state = User(email: email, password: password);
  }

  void userLogout() {
    _userRepository.deleteUser();
  }

  @override
  User build() {
    final email = _userRepository.getEmail();
    final password = _userRepository.getPassword();
    return User(email: email, password: password);
  }
}
