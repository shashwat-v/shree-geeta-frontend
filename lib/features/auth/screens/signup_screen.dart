import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';
import 'package:shree_geeta/components/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check password match
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() => _isLoading = true);

    try {
      final authProvider = context.read<AuthProvider>();

      final success = await authProvider.signup(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        // Signup successful - navigate to home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show error message
        _showErrorSnackBar(
          authProvider.error ?? 'Sign up failed. Please try again.',
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
                    'Register',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 2, width: 120, color: Colors.black),

                  const SizedBox(height: 24),

                  // Name Field
                  Text(
                    'Full Name',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText: 'Shree Krishna',
                      prefixIcon: const Icon(Icons.person_outline_rounded),
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
                        return 'Please enter your name';
                      }
                      if (value.trim().length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  Text(
                    'Email Address',
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
                      hintText: '12345678@gmail.com',
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

                  // Username Field
                  Text(
                    'Username',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText: 'krishna_devotee',
                      prefixIcon: const Icon(Icons.account_circle_outlined),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorStyle: const TextStyle(fontSize: 11),
                      helperText: 'No spaces, min 3 characters',
                      helperStyle: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.trim().length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      if (value.contains(' ')) {
                        return 'Username cannot contain spaces';
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
                    textInputAction: TextInputAction.next,
                    enabled: !_isLoading,
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
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Confirm Password Field
                  Text(
                    'Confirm Password',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    enabled: !_isLoading,
                    onFieldSubmitted: (_) => _handleSignUp(),
                    decoration: InputDecoration(
                      hintText: '••••••••••••••••',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                        icon: Icon(
                          _obscureConfirm
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
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.black54,
                        disabledForegroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
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
                          : const Text('Sign Up'),
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

                  // Google Sign Up
                  SocialButton(
                    label: 'Continue with Google',
                    icon: Icons.g_mobiledata_rounded,
                    onPressed: _isLoading
                        ? null
                        : () {
                            // TODO: Implement Google Sign Up
                            _showSuccessSnackBar('Google Sign Up coming soon!');
                          },
                  ),

                  const SizedBox(height: 18),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.of(context).maybePop();
                              },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 6),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sign in',
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
