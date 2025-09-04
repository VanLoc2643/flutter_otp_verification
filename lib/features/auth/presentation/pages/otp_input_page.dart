import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill_name/core/utils/extension/context_size_extension.dart';
import 'package:sms_autofill_name/features/auth/presentation/widgets/custom_elevated_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class OtpInputPage extends StatefulWidget {
  const OtpInputPage({super.key});

  @override
  State<OtpInputPage> createState() => _OtpInputPageState();
}

class _OtpInputPageState extends State<OtpInputPage> {
  String _otp = "";

  void _verify() {
    context.read<AuthBloc>().add(VerifyOtpEvent(_otp));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final screenHeight = context.height;

    final defaultTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade400),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpVerified) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pop(context);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Container(
              width: screenWidth,
              height: screenHeight,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 120.h,
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/256/14984/14984833.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Enter OTP",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Nhập mã đã gửi tới email của bạn!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                    ),
                    SizedBox(height: 24.h),
                    Pinput(
                      length: 6,
                      autofocus: true,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultTheme,
                      onChanged: (val) => setState(() => _otp = val),
                      onCompleted: (val) => _otp = val,
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: state is AuthLoading || _otp.length != 6
                            ? null
                            : _verify,
                        isLoading: state is AuthLoading,
                        text: "Xác thực",
                      ),
                    ),
                    SizedBox(height: 56.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
