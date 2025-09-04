import 'package:email_otp/email_otp.dart';

const String appName = 'Công ty Cổ phần Tập đoàn Meey Land';
const String otpEmailTemplate = '''
  <div style="background-color:#f4f6f9; padding:20px; font-family:Arial, Helvetica, sans-serif;">
    <div style="max-width:480px; margin:0 auto; background:#ffffff; border-radius:12px; box-shadow:0 6px 12px rgba(0,0,0,0.08); overflow:hidden;">
      <div style="background:linear-gradient(135deg,#0d47a1,#1976d2); color:#fff; padding:20px; text-align:center;">
        <h2 style="margin:0; font-size:20px;">{{appName}}</h2>
      </div>
      <div style="padding:24px; text-align:center; color:#333;">
        <h3 style="margin-bottom:16px;">Xác thực đăng nhập</h3>
        <p style="margin-bottom:12px;">Mã OTP của bạn là:</p>
        <div style="font-size:28px; font-weight:bold; letter-spacing:4px; color:#1976d2; margin:16px 0;">
          {{otp}}
        </div>
        <p style="margin-top:12px; color:#555;">Mã OTP này có hiệu lực trong <strong>3 phút</strong>.</p>
      </div>
      <div style="background:#f4f6f9; padding:16px; text-align:center; font-size:12px; color:#888;">
        © 2025 <a href="https://meeyland.com/" style="color:blue;">https://meeyland.com/</a>. All rights reserved.
      </div>
    </div>
  </div>
  ''';

void setupEmailOtp() {
  EmailOTP.config(
    appName: 'Công ty Cổ phần Tập đoàn Meey Land',
    appEmail: 'vanloc@mail.app',
    otpType: OTPType.numeric,
    otpLength: 6,
    expiry: 300000,
    emailTheme: EmailTheme.v6,
  );
  // EmailOTP.setTemplate(template: otpEmailTemplate);
}
