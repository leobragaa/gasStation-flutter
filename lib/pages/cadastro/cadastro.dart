import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/validators.dart';
import 'cadastro_viewmodel.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginVm = context.watch<CadastroViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/carTop.png", height: 160),
                const SizedBox(height: 20),

                const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Name:",
                          style: TextStyle(color: Color(0xFF1E1E1E)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: nameController,
                        validator: Validators.validateName,
                        decoration: const InputDecoration(
                          hintText: "Enter your name",
                        ),
                      ),

                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Email:",
                          style: TextStyle(color: Color(0xFF1E1E1E)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: emailController,
                        validator: Validators.validateEmail,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                        ),
                      ),

                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Password:",
                          style: TextStyle(color: Color(0xFF1E1E1E)),
                        ),
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

                      const SizedBox(height: 14),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirm Password:",
                          style: TextStyle(color: Color(0xFF1E1E1E)),
                        ),
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                              passwordController.text,
                              value,
                            ),
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Confirm your password",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/0/09/IOS_Google_icon.png",
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                loginVm.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;

                          final sucess = await loginVm.cadastro(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (sucess && mounted) {
                            Navigator.pushReplacementNamed(context, "/home");
                          }
                        },
                        child: const Text("Create an Account"),
                      ),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/login"),
                  child: const Text(
                    "Have an Account?",
                    style: TextStyle(color: Color(0xFFE1A8A8)),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
