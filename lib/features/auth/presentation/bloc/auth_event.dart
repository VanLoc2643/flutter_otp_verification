abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String email;
  SendOtpEvent(this.email);
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  VerifyOtpEvent(this.otp);
}
