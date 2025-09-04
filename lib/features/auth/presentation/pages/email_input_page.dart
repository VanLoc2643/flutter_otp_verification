import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill_name/core/utils/extension/context_size_extension.dart';
import 'package:sms_autofill_name/core/utils/validators.dart';
import 'package:sms_autofill_name/features/auth/presentation/widgets/custom_elevated_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'otp_input_page.dart';

class EmailInputPage extends StatefulWidget {
  const EmailInputPage({super.key});

  @override
  State<EmailInputPage> createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(text: "vanloc2643@gmail.com");

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      final email = _emailCtrl.text.trim();
      context.read<AuthBloc>().add(SendOtpEvent(email));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.width;
    final screenHeight = context.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpSent) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OtpInputPage()),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ảnh minh hoạ
                      SizedBox(
                        height: 120.h,
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/256/8662/8662284.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Signup/Login",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Nhập email của bạn",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: state is AuthLoading ? null : _sendOtp,
                          isLoading: state is AuthLoading,
                          text: "Send OTP",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
