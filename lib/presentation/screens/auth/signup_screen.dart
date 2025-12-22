import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../../core/theme/app_theme.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkText,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(begin: -0.2, end: 0),
                 const SizedBox(height: 8),
                Text(
                  'Join us to manage your tasks efficiently',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightText,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fade(delay: 200.ms).slideY(begin: -0.2, end: 0),
                const SizedBox(height: 48),
                CustomTextField(
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                  validator: (v) => v!.isEmpty ? 'Name is required' : null,
                ).animate().fade(delay: 300.ms).slideX(),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (v) => v!.isEmpty ? 'Email is required' : null,
                ).animate().fade(delay: 400.ms).slideX(),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
                ).animate().fade(delay: 500.ms).slideX(),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (v) {
                    if (v != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ).animate().fade(delay: 600.ms).slideX(),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Sign Up',
                  isLoading: _isLoading,
                  onPressed: _handleSignup,
                ).animate().fade(delay: 700.ms).scale(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await ref.read(authProvider.notifier).signup(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );
      if (mounted) {
        setState(() => _isLoading = false);
        if (ref.read(authProvider).isAuthenticated) {
          context.go('/home');
        }
      }
    }
  }
}
