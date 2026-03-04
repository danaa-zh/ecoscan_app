import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:ecoscan_app/features/profile/ui/profile_screen.dart';
import 'package:ecoscan_app/features/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _repeatCtrl = TextEditingController();

  @override
  void dispose() {
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
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        }
        if (state.status == AuthStatus.failure && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightGreen,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const OnboardingScreen(),
                      ),
                    );
                  },
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
                      'С возвращением',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4D7664),
                      ),
                    ),
                    const SizedBox(height: 54),
                    _AuthTextField(
                      hint: 'Введите логин',
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
                    _LoginButtons(
                      loginCtrl: _loginCtrl,
                      passCtrl: _passCtrl,
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

class _LoginButtons extends StatelessWidget {
  const _LoginButtons({
    required this.loginCtrl,
    required this.passCtrl,
  });

  final TextEditingController loginCtrl;
  final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final bool disabled = state.status == AuthStatus.loading;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 345,
          height: 51,
          child: FilledButton(
            onPressed: disabled
                ? null
                : () {
                    final login = loginCtrl.text.trim();
                    context.read<AuthBloc>().add(
                          AuthEmailSignInRequested(
                            login: login,
                            email: login,
                            password: passCtrl.text,
                          ),
                        );
                  },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.btn,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: state.status == AuthStatus.loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Войти',
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
        const SizedBox(height: 12),
        SizedBox(
          width: 345,
          height: 51,
          child: FilledButton(
            onPressed: disabled
                ? null
                : () {
                    context.read<AuthBloc>().add(const AuthGoogleSignInRequested());
                  },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: state.status == AuthStatus.loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Войти через Google',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}