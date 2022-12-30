part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required bool isLoading,
  }) = _Initial;

  factory LoginState.initial(){
    return const LoginState(isLoading: false);
  }
}
