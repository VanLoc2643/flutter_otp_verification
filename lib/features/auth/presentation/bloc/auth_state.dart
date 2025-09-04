abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSent extends AuthState {
  final String message;
  OtpSent(this.message);
}

class OtpVerified extends AuthState {
  final String message;
  OtpVerified(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
