import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart' hide EyeIconPressed, PasswordTextFieldChanged, EmailTextFieldChanged;
import 'bloc/register.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BasePageState<RegisterPage, RegisterBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      backgroundColor: const Color(0xFFFAFAF7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d24.responsive(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimens.d12.responsive()),
                // Back button
                GestureDetector(
                  onTap: () => navigator.canPopSelfOrChildren
                      ? navigator.pop()
                      : null,
                  child: Icon(
                    Icons.arrow_back,
                    size: Dimens.d20.responsive(),
                    color: const Color(0xFF111110),
                  ),
                ),
                SizedBox(height: Dimens.d20.responsive()),
                // Eyebrow
                Text(
                  'TẠO TÀI KHOẢN',
                  style: TextStyle(
                    fontSize: Dimens.d11.responsive(),
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B6862),
                  ),
                ),
                SizedBox(height: Dimens.d8.responsive()),
                // Title
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: Dimens.d28.responsive(),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF111110),
                      height: 1.2,
                    ),
                    children: const [
                      TextSpan(text: 'Bắt đầu với\n'),
                      TextSpan(
                        text: 'Nord.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimens.d24.responsive()),
                // Name field
                _buildLabel('Họ và tên'),
                SizedBox(height: Dimens.d6.responsive()),
                TextField(
                  onChanged: (name) =>
                      bloc.add(NameTextFieldChanged(name: name)),
                  keyboardType: TextInputType.name,
                  decoration: _inputDecoration('An Nguyễn'),
                ),
                SizedBox(height: Dimens.d16.responsive()),
                // Email field
                _buildLabel('Email'),
                SizedBox(height: Dimens.d6.responsive()),
                TextField(
                  onChanged: (email) =>
                      bloc.add(EmailTextFieldChanged(email: email)),
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration('ban@email.com'),
                ),
                SizedBox(height: Dimens.d16.responsive()),
                // Password field
                _buildLabel('Mật khẩu'),
                SizedBox(height: Dimens.d6.responsive()),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, cur) =>
                      prev.obscureText != cur.obscureText,
                  builder: (context, state) {
                    return TextField(
                      onChanged: (pass) => bloc
                          .add(PasswordTextFieldChanged(password: pass)),
                      obscureText: state.obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: _inputDecoration('••••••••').copyWith(
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              bloc.add(const EyeIconPressed()),
                          child: Icon(
                            !state.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: Dimens.d20.responsive(),
                            color: const Color(0xFFA5A199),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Dimens.d16.responsive()),
                // Confirm Password field
                _buildLabel('Nhập lại mật khẩu'),
                SizedBox(height: Dimens.d6.responsive()),
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, cur) =>
                      prev.confirmObscureText != cur.confirmObscureText,
                  builder: (context, state) {
                    return TextField(
                      onChanged: (pass) => bloc
                          .add(ConfirmPasswordTextFieldChanged(confirmPassword: pass)),
                      obscureText: state.confirmObscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: _inputDecoration('••••••••').copyWith(
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              bloc.add(const ConfirmEyeIconPressed()),
                          child: Icon(
                            !state.confirmObscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: Dimens.d20.responsive(),
                            color: const Color(0xFFA5A199),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Dimens.d16.responsive()),
                // Terms and conditions
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, cur) =>
                      prev.isTermsAccepted != cur.isTermsAccepted,
                  builder: (context, state) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Dimens.d18.responsive(),
                          height: Dimens.d18.responsive(),
                          child: Checkbox(
                            value: state.isTermsAccepted,
                            onChanged: (val) => bloc.add(
                              TermsCheckboxToggled(
                                  isAccepted: val ?? false),
                            ),
                            activeColor: const Color(0xFF111110),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        SizedBox(width: Dimens.d8.responsive()),
                        Expanded(
                          child: Text(
                            'Tôi đồng ý với Điều khoản sử dụng và Chính sách bảo mật của Nord',
                            style: TextStyle(
                              fontSize: Dimens.d12.responsive(),
                              color: const Color(0xFF6B6862),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: Dimens.d24.responsive()),
                // Error text
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, cur) =>
                      prev.onPageError != cur.onPageError,
                  builder: (_, state) {
                    if (state.onPageError.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: Dimens.d12.responsive()),
                      child: Text(
                        state.onPageError,
                        style: TextStyle(
                          fontSize: Dimens.d13.responsive(),
                          color: const Color(0xFFC2410C),
                        ),
                      ),
                    );
                  },
                ),
                // Register button
                BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (prev, cur) =>
                      prev.isRegisterButtonEnabled !=
                      cur.isRegisterButtonEnabled,
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: Dimens.d48.responsive(),
                      child: ElevatedButton(
                        onPressed: state.isRegisterButtonEnabled
                            ? () =>
                                bloc.add(const RegisterButtonPressed())
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111110),
                          disabledBackgroundColor:
                              const Color(0xFF111110).withValues(alpha: 0.4),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Dimens.d8.responsive()),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Tạo tài khoản',
                          style: TextStyle(
                            fontSize: Dimens.d15.responsive(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Dimens.d24.responsive()),
                // Divider "hoặc"
                Row(
                  children: [
                    const Expanded(
                        child: Divider(color: Color(0xFFE8E5DE))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.d12.responsive()),
                      child: Text(
                        'HOẶC',
                        style: TextStyle(
                          fontSize: Dimens.d11.responsive(),
                          letterSpacing: 1.1,
                          color: const Color(0xFFA5A199),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Divider(color: Color(0xFFE8E5DE))),
                  ],
                ),
                SizedBox(height: Dimens.d16.responsive()),
                // Social login buttons
                _buildSocialButton(Icons.g_mobiledata, 'Tiếp tục với Google'),
                SizedBox(height: Dimens.d12.responsive()),
                _buildSocialButton(Icons.apple, 'Tiếp tục với Apple'),
                SizedBox(height: Dimens.d24.responsive()),
                // Already have account -> Login link
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Đã có tài khoản? ',
                      style: TextStyle(
                        fontSize: Dimens.d12.responsive(),
                        color: const Color(0xFF6B6862),
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => navigator.pop(),
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontSize: Dimens.d12.responsive(),
                                color: const Color(0xFF111110),
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimens.d32.responsive()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: Dimens.d11.responsive(),
        letterSpacing: 1.1,
        color: const Color(0xFF6B6862),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: Dimens.d14.responsive(),
        color: const Color(0xFFA5A199),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Dimens.d14.responsive(),
        vertical: Dimens.d12.responsive(),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
        borderSide: const BorderSide(color: Color(0xFFE8E5DE)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
        borderSide: const BorderSide(color: Color(0xFFE8E5DE)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
        borderSide: const BorderSide(color: Color(0xFF111110)),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.d44.responsive(),
      child: OutlinedButton.icon(
        onPressed: () {
          // ponytail: social registration, add when backend supports
        },
        icon: Icon(icon, size: Dimens.d18.responsive()),
        label: Text(
          label,
          style: TextStyle(fontSize: Dimens.d14.responsive()),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF111110),
          side: const BorderSide(color: Color(0xFFE8E5DE)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
