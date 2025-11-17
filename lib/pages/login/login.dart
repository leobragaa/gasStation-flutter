import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/validators.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginVm = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/carTop.png", height: 160),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email:",
                        style: TextStyle(color: Color(0xFF1E1E1E)),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: emailController,
                        validator: Validators.validateEmail,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Password:",
                        style: TextStyle(color: Color(0xFF1E1E1E)),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: passwordController,
                        validator: Validators.validatePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFFE1A8A8)),
                  ),
                ),

                if (loginVm.state.emailError != null)
                  Text(
                    loginVm.state.emailError!,
                    style: const TextStyle(color: Colors.red),
                  ),

                if (loginVm.state.passwordError != null)
                  Text(
                    loginVm.state.passwordError!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: () async {
                    final sucess = await loginVm.loginWithGoogle();
                    if (sucess && mounted) {
                      Navigator.pushReplacementNamed(context, "/home");
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png",
                      height: 32,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                loginVm.state.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;
                          final sucess = await loginVm.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (sucess && mounted) {
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        child: const Text("Login"),
                      ),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/cadastro"),
                  child: const Text(
                    "Dont't have an Account?",
                    style: TextStyle(color: Color(0xFFE1A8A8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
