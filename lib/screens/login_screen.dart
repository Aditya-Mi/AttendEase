import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/widgets/custom_circular_indicator.dart';
import 'package:attendease/repositories/auth_repository.dart';
import 'package:attendease/screens/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;
  var _enteredPassword = '';
  var _enteredUsername = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  Center(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 11),
                    child: Text(
                      'Login Id',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.text100,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email or phone number',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: AppColors.text200.withOpacity(0.55),
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.text100),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length < 4) {
                        return 'Please enter at least 4 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredUsername = value!;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 11),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.text100,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: AppColors.text200.withOpacity(0.55),
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.text100),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'Password must be atleast 6 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                  _isLoading
                      ? const Center(child: CustomCircularIndicator())
                      : GestureDetector(
                          onTap: () async {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            _formKey.currentState!.save();
                            setState(() {
                              _isLoading = true;
                            });
                            bool result = await AuthRepository().login(
                                username: _enteredUsername,
                                password: _enteredPassword);
                            if (result && context.mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: AppColors.primary100,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.bg200,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
