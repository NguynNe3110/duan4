import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import 'bloc/forgot_password.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState
    extends BasePageState<ForgotPasswordPage, ForgotPasswordBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      backgroundColor: const Color(0xFFFAFAF7),
      appBar: CommonAppBar(
        leadingIcon: LeadingIcon.back,
        text: '',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if (state.isEmailSent) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mark_email_read_outlined,
                        size: 64,
                        color: Color(0xFF111110),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Đã gửi liên kết đặt lại',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chúng tôi đã gửi hướng dẫn đặt lại mật khẩu đến email ${state.email}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF6B6862),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => navigator.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111110),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Quay lại đăng nhập'),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'QUÊN MẬT KHẨU',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B6862),
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111110),
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(text: 'Khôi phục\n'),
                        TextSpan(
                          text: 'mật khẩu của bạn.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Nhập địa chỉ email đã đăng ký tài khoản. Chúng tôi sẽ gửi hướng dẫn để bạn đặt lại mật khẩu.',
                    style: TextStyle(
                      color: Color(0xFF6B6862),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'EMAIL',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.1,
                      color: Color(0xFF6B6862),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    onChanged: (email) => bloc.add(
                      ForgotPasswordEmailChanged(email: email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'ban@email.com',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFA5A199),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE8E5DE)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state.isButtonEnabled
                          ? () => bloc.add(const SendResetCodePressed())
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF111110),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Gửi yêu cầu'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
