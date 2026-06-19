import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/renbok_logo.dart';
import '../../../services/api_service.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!mounted) return;

    if (ok) {
      final interestsDone =
          await ref.read(authStorageProvider).isInterestsSetupComplete();
      if (!mounted) return;

      if (interestsDone) {
        context.go('/main');
      } else {
        context.go('/interests');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(authProvider).error ?? 'Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final topHeight =
                (constraints.maxHeight * 0.30).clamp(180.0, 230.0);

            return SizedBox(
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: topHeight + 46,
                    child: Image.asset(
                      'img/img login.png',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.05, -0.72),
                    ),
                  ),
                  Container(
                    height: topHeight + 46,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.22),
                          Colors.white.withValues(alpha: 0.10),
                          Colors.white.withValues(alpha: 0.86),
                        ],
                      ),
                    ),
                  ),
                  const SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32, top: 46),
                      child: RenbokLogo(size: 34, showSubtitle: true),
                    ),
                  ),
                  Positioned.fill(
                    top: topHeight,
                    child: _LoginPanel(
                      availableHeight: constraints.maxHeight - topHeight,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      obscure: _obscure,
                      rememberMe: _rememberMe,
                      isLoading: auth.isLoading,
                      onToggleObscure: () {
                        setState(() => _obscure = !_obscure);
                      },
                      onRememberChanged: (value) {
                        setState(() => _rememberMe = value ?? !_rememberMe);
                      },
                      onLogin: _login,
                      onRegister: () => context.go('/register'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel({
    required this.availableHeight,
    required this.emailController,
    required this.passwordController,
    required this.obscure,
    required this.rememberMe,
    required this.isLoading,
    required this.onToggleObscure,
    required this.onRememberChanged,
    required this.onLogin,
    required this.onRegister,
  });

  final double availableHeight;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscure;
  final bool rememberMe;
  final bool isLoading;
  final VoidCallback onToggleObscure;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final compact = availableHeight < 560;

    return Container(
      width: double.infinity,
      height: availableHeight,
      padding: EdgeInsets.fromLTRB(32, compact ? 24 : 28, 32, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F1B4332),
            blurRadius: 34,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            alignment: Alignment.topCenter,
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'Selamat datang\nkembali, Explorer!',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: compact ? 26 : 28,
                            height: 1.08,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF143B39),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 3),
                        child: Icon(
                          Icons.energy_savings_leaf_outlined,
                          color: AppColors.forestGreen,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 8 : 10),
                  Text(
                    'Masuk untuk melanjutkan petualanganmu.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7B8190),
                    ),
                  ),
                  SizedBox(height: compact ? 16 : 18),
                  _LoginTextField(
                    controller: emailController,
                    icon: Icons.mail_outline_rounded,
                    hint: 'Email atau username',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email atau username wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _LoginTextField(
                    controller: passwordController,
                    icon: Icons.lock_outline_rounded,
                    hint: 'Password',
                    obscureText: obscure,
                    suffix: IconButton(
                      onPressed: onToggleObscure,
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF7B8190),
                        size: 22,
                      ),
                    ),
                    validator: (value) => value == null || value.length < 6
                        ? 'Minimal 6 karakter'
                        : null,
                  ),
                  SizedBox(height: compact ? 10 : 12),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: onRememberChanged,
                          activeColor: AppColors.forestGreen,
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(
                            color: AppColors.forestGreen,
                            width: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Ingat saya',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.forestGreen,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Text('Lupa password?'),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 14 : 16),
                  _PrimaryLoginButton(isLoading: isLoading, onPressed: onLogin),
                  SizedBox(height: compact ? 14 : 16),
                  const _DividerLabel(label: 'atau masuk dengan'),
                  SizedBox(height: compact ? 12 : 14),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      side: const BorderSide(color: Color(0xFFE9E2DB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      foregroundColor: Colors.black,
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'G',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4285F4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text('Lanjut dengan Google'),
                      ],
                    ),
                  ),
                  SizedBox(height: compact ? 14 : 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: const Color(0xFF5F6673),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: onRegister,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.forestGreen,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        child: const Text('Daftar sekarang'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.controller,
    required this.icon,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 10),
            child: Icon(icon, color: AppColors.forestGreen, size: 23),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 52),
          suffixIcon: suffix,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFFE8E0D8), width: 1.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: AppColors.forestGreen, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.error, width: 1.4),
          ),
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF828895),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PrimaryLoginButton extends StatelessWidget {
  const _PrimaryLoginButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF145A36), Color(0xFF2E7A4A)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withValues(alpha: 0.20),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 46),
                  Text(
                    'Masuk',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 27,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE8E2DB))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF7B8190),
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE8E2DB))),
      ],
    );
  }
}
