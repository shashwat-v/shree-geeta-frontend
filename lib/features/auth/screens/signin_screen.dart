import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';
import 'package:shree_geeta/components/social_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AuthProvider>();

      final success = await authProvider.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        // Login successful - navigate to home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show error message
        _showErrorSnackBar(
          authProvider.error ?? 'Login failed. Please try again.',
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('An unexpected error occurred');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Back Button
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  const SizedBox(height: 8),

                  // Logo/Icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.star_border, color: Colors.white),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Please login to your account',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),

                  const SizedBox(height: 24),

                  // Email Field
                  Text(
                    'E-mail Address',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText: 'hare.krishna@gmail.com',
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle: const TextStyle(fontSize: 11),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  Text(
                    'Password',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    enabled: !_isLoading,
                    onFieldSubmitted: (_) => _handleLogin(),
                    decoration: InputDecoration(
                      hintText: '••••••••••••••••',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle: const TextStyle(fontSize: 11),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Remember Me & Forgot Password
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: _isLoading
                              ? null
                              : (bool? v) {
                                  setState(() {
                                    _rememberMe = v ?? false;
                                  });
                                },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Remember me',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                // TODO: Navigate to forgot password screen
                                _showSuccessSnackBar(
                                  'Forgot password feature coming soon!',
                                );
                              },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.black54,
                        disabledForegroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Divider
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Or',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Google Sign In
                  SocialButton(
                    label: 'Continue with Google',
                    icon: Icons.g_mobiledata_rounded,
                    onPressed: _isLoading
                        ? null
                        : () {
                            // TODO: Implement Google Sign In
                            _showSuccessSnackBar('Google Sign In coming soon!');
                          },
                  ),

                  const SizedBox(height: 18),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have account?",
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pushNamed(context, '/signup');
                              },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 6),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
