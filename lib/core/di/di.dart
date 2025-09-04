import 'package:email_otp/email_otp.dart';
import 'package:get_it/get_it.dart';
import 'package:sms_autofill_name/features/auth/data/datasources/email_otp_service.dart';
import 'package:sms_autofill_name/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sms_autofill_name/features/auth/domain/repositories/auth_repository.dart';
import 'package:sms_autofill_name/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:sms_autofill_name/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:sms_autofill_name/features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setupDi() {
  getIt.registerLazySingleton<EmailOtpService>(() => EmailOtpService());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<EmailOtpService>()),
  );

  getIt.registerLazySingleton(() => SendOtpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt<AuthRepository>()));

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<SendOtpUseCase>(), getIt<VerifyOtpUseCase>()),
  );
}
