import '../entities/otp_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<OtpEntity> call(String otp) {
    return repository.verifyOtp(otp);
  }
}
