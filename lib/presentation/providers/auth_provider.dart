import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mock User State
class AuthState {
  final bool isAuthenticated;
  final String? userName;

  AuthState({this.isAuthenticated = false, this.userName});

  AuthState copyWith({bool? isAuthenticated, String? userName}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock logic: allow any login
    state = state.copyWith(isAuthenticated: true, userName: "Jack");
  }

  Future<void> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isAuthenticated: true, userName: name);
  }

  void logout() {
    state = AuthState(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
