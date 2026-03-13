import 'package:ecoscan_app/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/features/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _loginCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _repeatCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _loginCtrl.dispose();
    _passCtrl.dispose();
    _repeatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.go(RouteNames.profilePath);
        }
        if (state.status == AuthStatus.failure && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.greenBg,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 20,
                child: GestureDetector(
                  onTap: () => context.go(RouteNames.onboardingPath),
                  child: Image.asset(
                    'assets/green-left-arrow.png',
                    width: 16,
                    height: 9,
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 216),
                    const Text(
                      'EcoScan',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: AppColors.brandGreen,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Добро пожаловать!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4D7664),
                      ),
                    ),
                    const SizedBox(height: 54),
                    _AuthTextField(
                      hint: 'Введите имя и фамилию',
                      controller: _nameCtrl,
                    ),
                    const SizedBox(height: 12),
                    _AuthTextField(
                      hint: 'Введите email',
                      controller: _emailCtrl,
                    ),
                    const SizedBox(height: 12),
                    _AuthTextField(
                      hint: 'Введите username',
                      controller: _loginCtrl,
                    ),
                    const SizedBox(height: 12),
                    _AuthTextField(
                      hint: 'Введите пароль',
                      obscureText: true,
                      controller: _passCtrl,
                    ),
                    const SizedBox(height: 12),
                    _AuthTextField(
                      hint: 'Повторите пароль',
                      obscureText: true,
                      controller: _repeatCtrl,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 345,
                      height: 51,
                      child: FilledButton(
                        onPressed:
                            context.watch<AuthBloc>().state.status ==
                                AuthStatus.loading
                            ? null
                            : () {
                                final login = _loginCtrl.text.trim();
                                context.read<AuthBloc>().add(
                                  AuthRegisterRequested(
                                    name: _nameCtrl.text.trim(),
                                    surname: '',
                                    email: _emailCtrl.text.trim(),
                                    login: login,
                                    password: _passCtrl.text,
                                    repeatPassword: _repeatCtrl.text,
                                  ),
                                );
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.btn,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child:
                            context.watch<AuthBloc>().state.status ==
                                AuthStatus.loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 37),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.hint,
    required this.controller,
    this.obscureText = false,
  });

  final String hint;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      height: 58,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.placeholder,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.only(left: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(31),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
