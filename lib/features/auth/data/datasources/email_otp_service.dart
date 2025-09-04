import 'package:email_otp/email_otp.dart';

class EmailOtpService {
  Future<bool> sendOtp(String email) async {
    return await EmailOTP.sendOTP(email: email);
  }

  Future<bool> verifyOtp(String otp) async {
    return await EmailOTP.verifyOTP(otp: otp);
  }

  bool isExpired() {
    return EmailOTP.isOtpExpired();
  }
}
