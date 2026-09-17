part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {} //user is log out

final class AppUserLogIn extends AppUserState {
  final User user;
  AppUserLogIn(this.user);
}
//core cannot depends on other feature but other can user