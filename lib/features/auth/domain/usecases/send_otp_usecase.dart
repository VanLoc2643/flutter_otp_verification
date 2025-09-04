import '../entities/otp_entity.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;
  SendOtpUseCase(this.repository);

  Future<OtpEntity> call(String email) {
    return repository.sendOtp(email);
  }
}
