import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flowdeck/data/models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    String? error,
  }) = _AuthState;
}

extension AuthStateX on AuthState {
  bool get hasError => error != null;

  bool get isInitial => !isAuthenticated && !isLoading && !hasError;
}
