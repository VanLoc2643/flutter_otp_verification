import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill_name/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:sms_autofill_name/features/auth/domain/usecases/verify_otp_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthBloc(this.sendOtpUseCase, this.verifyOtpUseCase) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await sendOtpUseCase(event.email);
      result.success
          ? emit(OtpSent(result.message ?? ""))
          : emit(AuthError(result.message ?? ""));
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading()); //đầu tiên goi cái này trc
      final result = await verifyOtpUseCase(event.otp);
      result.success
          ? emit(OtpVerified(result.message ?? ""))
          : emit(AuthError(result.message ?? ""));
    });
  }
}
