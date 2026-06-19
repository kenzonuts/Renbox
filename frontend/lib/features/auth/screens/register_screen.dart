import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await ref.read(authProvider.notifier).register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _nameController.text.trim(),
          username: _usernameController.text.trim().toLowerCase(),
        );

    if (!mounted) return;

    if (ok) {
      context.go('/interests');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ref.read(authProvider).error ?? 'Registrasi gagal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final topHeight =
                (constraints.maxHeight * 0.28).clamp(170.0, 215.0);

            return SizedBox(
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: topHeight + 48,
                    child: Image.asset(
                      'img/img login.png',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.05, -0.72),
                    ),
                  ),
                  Container(
                    height: topHeight + 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.04),
                          Colors.white.withValues(alpha: 0.68),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 20),
                      child: IconButton(
                        onPressed: () => context.go('/login'),
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: AppColors.deepForest,
                        iconSize: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 86,
                    child: IgnorePointer(
                      child: Image.asset(
                        'img/asetlogin.png',
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: topHeight,
                    child: _RegisterPanel(
                      availableHeight: constraints.maxHeight - topHeight,
                      nameController: _nameController,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      obscurePassword: _obscurePassword,
                      obscureConfirm: _obscureConfirm,
                      isLoading: auth.isLoading,
                      onTogglePassword: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      onToggleConfirm: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                      onRegister: _register,
                      onLogin: () => context.go('/login'),
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

class _RegisterPanel extends StatelessWidget {
  const _RegisterPanel({
    required this.availableHeight,
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirm,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onToggleConfirm,
    required this.onRegister,
    required this.onLogin,
  });

  final double availableHeight;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirm;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirm;
  final VoidCallback onRegister;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final compact = availableHeight < 590;

    return Container(
      width: double.infinity,
      height: availableHeight,
      padding: EdgeInsets.fromLTRB(24, compact ? 30 : 34, 24, 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x00FFFFFF),
            Color(0xD9FFFFFF),
            Colors.white,
            Colors.white,
            Color(0xEFFFFFFF),
            Color(0x00FFFFFF),
          ],
          stops: [0.0, 0.08, 0.16, 0.72, 0.86, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x121B4332),
            blurRadius: 28,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 96,
            ),
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
                          'Buat Akun Baru',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: compact ? 25 : 27,
                            height: 1.08,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF143B39),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Icons.energy_savings_leaf_outlined,
                          color: AppColors.forestGreen,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? 7 : 8),
                  Text(
                    'Yuk mulai petualanganmu bersama RENBOK.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7B8190),
                    ),
                  ),
                  SizedBox(height: compact ? 12 : 14),
                  _RegisterTextField(
                    controller: nameController,
                    icon: Icons.person_outline_rounded,
                    label: 'Nama Lengkap',
                    hint: 'Masukkan nama lengkap',
                    validator: (value) =>
                        value == null || value.trim().length < 2
                            ? 'Nama wajib diisi'
                            : null,
                  ),
                  const SizedBox(height: 8),
                  _RegisterTextField(
                    controller: usernameController,
                    icon: Icons.alternate_email_rounded,
                    label: 'Username',
                    hint: 'Masukkan username',
                    validator: (value) =>
                        value == null || value.trim().length < 3
                            ? 'Minimal 3 karakter'
                            : null,
                  ),
                  const SizedBox(height: 8),
                  _RegisterTextField(
                    controller: emailController,
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    hint: 'Masukkan email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || !value.contains('@')
                        ? 'Email tidak valid'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  _RegisterTextField(
                    controller: passwordController,
                    icon: Icons.lock_outline_rounded,
                    label: 'Password',
                    hint: 'Masukkan password',
                    obscureText: obscurePassword,
                    suffix: IconButton(
                      onPressed: onTogglePassword,
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF7B8190),
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 38,
                      ),
                    ),
                    validator: (value) => value == null || value.length < 8
                        ? 'Minimal 8 karakter'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  _RegisterTextField(
                    controller: confirmPasswordController,
                    icon: Icons.lock_outline_rounded,
                    label: 'Konfirmasi Password',
                    hint: 'Masukkan kembali password',
                    obscureText: obscureConfirm,
                    suffix: IconButton(
                      onPressed: onToggleConfirm,
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF7B8190),
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 38,
                      ),
                    ),
                    validator: (value) => value != passwordController.text
                        ? 'Password tidak sama'
                        : null,
                  ),
                  SizedBox(height: compact ? 14 : 16),
                  _RegisterButton(
                    isLoading: isLoading,
                    onPressed: onRegister,
                  ),
                  SizedBox(height: compact ? 15 : 17),
                  const _DividerLabel(label: 'atau'),
                  SizedBox(height: compact ? 11 : 13),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      side: const BorderSide(color: Color(0xFFE9E2DB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      foregroundColor: Colors.black,
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'G',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4285F4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text('Daftar dengan Google'),
                      ],
                    ),
                  ),
                  SizedBox(height: compact ? 18 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun? ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: const Color(0xFF5F6673),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: onLogin,
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.forestGreen,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        child: const Text('Masuk di sini'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RegisterTextField extends StatelessWidget {
  const _RegisterTextField({
    required this.controller,
    required this.icon,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8),
            child: Icon(icon, color: AppColors.deepForest, size: 19),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 46),
          suffixIcon: suffix,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8E0D8), width: 1.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                const BorderSide(color: AppColors.forestGreen, width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.error, width: 1.4),
          ),
          labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: const Color(0xFF414C55),
            fontWeight: FontWeight.w700,
          ),
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF828895),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
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
        borderRadius: BorderRadius.circular(22),
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
          minimumSize: const Size.fromHeight(44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
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
            : Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      'Daftar Sekarang',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 21,
                        color: Colors.white,
                      ),
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
