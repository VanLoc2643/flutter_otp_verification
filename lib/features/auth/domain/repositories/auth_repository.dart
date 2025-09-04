import '../entities/otp_entity.dart';

abstract class AuthRepository {
  Future<OtpEntity> sendOtp(String email);
  Future<OtpEntity> verifyOtp(String otp);
}
