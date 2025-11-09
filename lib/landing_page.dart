import 'package:flutter/material.dart';
import 'package:shree_geeta/signin_screen.dart';
import 'package:shree_geeta/signup_screen.dart';

class GetStarted
    extends
        StatelessWidget {
  const GetStarted({
    super.key,
  });

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
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  <
                    Widget
                  >[
                    // Top logo and app name
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          <
                            Widget
                          >[
                            // Placeholder for logo
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  255,
                                  153,
                                  51,
                                ),
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove_red_eye,
                                color: Color.fromARGB(
                                  255,
                                  255,
                                  153,
                                  51,
                                ),
                                size: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  const <
                                    Widget
                                  >[
                                    Text(
                                      'Shree Geeta',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                            ),
                          ],
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    // Illustration placeholder box (replace with asset later)
                    Container(
                      width: 260,
                      height: 220,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFF7F7F7,
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.flight_takeoff,
                        color: Color(
                          0xFF27AE60,
                        ),
                        size: 72,
                      ),
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    // Title
                    const Text(
                      'Welcome to Shree Geeta!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // Subtitle
                    const Text(
                      "Let's get booked for interviews on podcasts.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    // Primary CTA
                    SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            153,
                            51,
                          ),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (
                                      context,
                                    ) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                const <
                                  Widget
                                >[
                                  Text(
                                    'Get Started',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                  ),
                                ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Secondary links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          <
                            Widget
                          >[
                            Text(
                              'Having issues? ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(
                                  0,
                                  0,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Get Help',
                                style: TextStyle(
                                  color: Color.fromARGB(
                                    255,
                                    255,
                                    153,
                                    51,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          <
                            Widget
                          >[
                            Text(
                              'Already have an Account? ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (
                                          _,
                                        ) => const SignInScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(
                                  0,
                                  0,
                                ),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Color(
                                    0xFF2F80ED,
                                  ),
                                  fontWeight: FontWeight.w600,
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
