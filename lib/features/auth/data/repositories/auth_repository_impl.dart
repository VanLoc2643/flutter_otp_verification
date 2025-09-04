import '../../domain/entities/otp_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/email_otp_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final EmailOtpService service;
  AuthRepositoryImpl(this.service);

  @override
  Future<OtpEntity> sendOtp(String email) async {
    final ok = await service.sendOtp(email);
    return OtpEntity(success: ok, message: ok ? "OTP sent" : "Send failed");
  }

  @override
  Future<OtpEntity> verifyOtp(String otp) async {
    if (service.isExpired()) {
      return OtpEntity(success: false, message: "OTP expired");
    }
    final ok = await service.verifyOtp(otp);
    return OtpEntity(success: ok, message: ok ? "OTP valid" : "Invalid OTP");
  }
}
