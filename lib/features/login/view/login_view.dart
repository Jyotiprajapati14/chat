import 'package:chat_app/features/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("User Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: p.formKey,
          child: Column(
            children: [
              _gender(),
              _field(
                controller: p.nameCtrl,
                label: "Full Name",
                icon: Icons.person,
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),
              _field(
                controller: p.phoneCtrl,
                label: "Phone Number",
                icon: Icons.phone,
                maxLen: 10,
                keyboard: TextInputType.phone,
                validator: (v) =>
                    v!.length < 10 ? "Invalid phone number" : null,
              ),
              _field(
                controller: p.emailCtrl,
                label: "Email",
                icon: Icons.email,
                keyboard: TextInputType.emailAddress,
                validator: (v) => !v!.contains("@") ? "Invalid email" : null,
              ),
              _field(
                controller: p.passwordCtrl,
                label: "Password",
                icon: Icons.lock,
                obscure: true,
                validator: (v) => v!.length < 6 ? "Min 6 characters" : null,
              ),
              _field(
                controller: p.addressCtrl,
                label: "Address",
                icon: Icons.location_on,
                maxLines: 2,
                validator: (v) => v!.isEmpty ? "Enter address" : null,
              ),
              const SizedBox(height: 20),
              _signup(context, p),
              const SizedBox(height: 20),
              _login(context, p),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gender() {
    return Selector<LoginProvider, String?>(
      selector: (_, p) => p.gender,
      builder: (context, gender, _) {
        final p = context.read<LoginProvider>();

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: DropdownButtonFormField<String>(
            value: gender,
            decoration: InputDecoration(
              labelText: "Gender",
              prefixIcon: const Icon(Icons.people),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const [
              DropdownMenuItem(value: "Male", child: Text("Male")),
              DropdownMenuItem(value: "Female", child: Text("Female")),
            ],
            onChanged: p.setGender,
            validator: (v) => v == null ? "Select gender" : null,
          ),
        );
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    int maxLines = 1,
    int? maxLen,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        obscureText: obscure,
        maxLines: maxLines,
        maxLength: maxLen,
        validator: validator,

        decoration: InputDecoration(
          labelText: label,
          counterText: '',
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context, LoginProvider p) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => p.singup(context),
        child: const Text("SIGNUP"),
      ),
    );
  }

  Widget _login(BuildContext context, LoginProvider p) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => p.login(context),
        child: const Text("LOGIN"),
      ),
    );
  }
}
