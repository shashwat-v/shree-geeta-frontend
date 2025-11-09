import 'package:flutter/material.dart';

class SignUpScreen
    extends
        StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<
    SignUpScreen
  >
  createState() => _SignUpScreenState();
}

class _SignUpScreenState
    extends
        State<
          SignUpScreen
        > {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final ThemeData theme = Theme.of(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  <
                    Widget
                  >[
                    IconButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).maybePop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // Small logo tile
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 2,
                      width: 120,
                      color: Colors.black,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    Text(
                      'Enter your email',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: '12345678@gmail.com',
                        prefixIcon: const Icon(
                          Icons.alternate_email_rounded,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      'Enter your password',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: '••••••••••••••••',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _obscurePassword = !_obscurePassword;
                              },
                            );
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
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      'Re-Enter your password',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        hintText: '••••••••••••••••',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _obscureConfirm = !_obscureConfirm;
                              },
                            );
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
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign Up',
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      children:
                          <
                            Widget
                          >[
                            Expanded(
                              child: Container(
                                height: 1,
                                color: const Color(
                                  0xFFE9E9E9,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
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
                                color: const Color(
                                  0xFFE9E9E9,
                                ),
                              ),
                            ),
                          ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    _SocialButton(
                      label: 'Continue with Google',
                      icon: Icons.g_mobiledata_rounded,
                      onPressed: () {},
                    ),

                    // const SizedBox(
                    //   height: 12,
                    // ),

                    // _SocialButton(
                    //   label: 'Continue with Apple',
                    //   icon: Icons.apple,
                    //   onPressed: () {},
                    // ),
                    const SizedBox(
                      height: 18,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          <
                            Widget
                          >[
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).maybePop();
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                  left: 6,
                                ),
                                minimumSize: const Size(
                                  0,
                                  0,
                                ),
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
    );
  }
}

class _SocialButton
    extends
        StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              14,
            ),
          ),
          side: const BorderSide(
            color: Color(
              0xFFE1E1E1,
            ),
          ),
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              <
                Widget
              >[
                Icon(
                  icon,
                  size: 22,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                ),
              ],
        ),
      ),
    );
  }
}
