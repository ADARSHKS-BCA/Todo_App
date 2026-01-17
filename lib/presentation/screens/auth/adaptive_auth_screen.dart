import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/primary_button.dart';

class AdaptiveAuthScreen extends ConsumerStatefulWidget {
  const AdaptiveAuthScreen({super.key});

  @override
  ConsumerState<AdaptiveAuthScreen> createState() => _AdaptiveAuthScreenState();
}

class _AdaptiveAuthScreenState extends ConsumerState<AdaptiveAuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authProvider.notifier);
      if (_isLogin) {
        await authNotifier.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          context,
        );
      } else {
        await authNotifier.signup(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          context,
        );
      }
      
      // Check if authentication was successful
      if (ref.read(authProvider).isAuthenticated) {
        if (mounted) context.go('/home');
      }
    }
  }

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    // Dynamic strings based on mode
    final title = _isLogin ? 'Welcome Back' : 'Create Account';
    final subtitle = _isLogin 
      ? 'Enter your credentials to access your tasks.' 
      : 'Join us and start organizing your life today.';
    final buttonText = _isLogin ? 'Log In' : 'Sign Up';
    final switchText = _isLogin ? "Don't have an account? " : 'Already have an account? ';
    final switchAction = _isLogin ? 'Sign Up' : 'Log In';

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   // Brand Icon
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
                  
                  const SizedBox(height: 24),
                  
                  // Title & Subtitle with Animation
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium,
                  ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 100.ms),

                  const SizedBox(height: 48),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email is required';
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible 
                            ? Icons.visibility_off_outlined 
                            : Icons.visibility_outlined
                        ),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),

                  if (_isLogin) ...[
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement Forgot Password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Forgot Password feature coming soon')),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ).animate().fadeIn(delay: 350.ms),
                  ] else ...[
                     const SizedBox(height: 16), // Spacing for SignUp mode where forgot pass isn't shown
                  ],

                  const SizedBox(height: 24),

                  // Primary Action Button
                  PrimaryButton(
                    text: buttonText,
                    isLoading: authState.isLoading,
                    onPressed: _submit,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Switch Mode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(switchText, style: theme.textTheme.bodyMedium),
                      GestureDetector(
                        onTap: _toggleMode,
                        child: Text(
                          switchAction,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 500.ms),
                  
                  if (authState.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        authState.errorMessage!,
                        style: TextStyle(color: theme.colorScheme.error),
                        textAlign: TextAlign.center,
                      ),
                    ).animate().shake(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
