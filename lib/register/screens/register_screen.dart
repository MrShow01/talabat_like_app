import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/register/controller/register_cubit.dart';
import 'package:talabat_like_app/register/controller/register_state.dart';
import 'package:talabat_like_app/view/root_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            showAboutDialog(
              context: context,
              barrierDismissible: true,
              children: [Text(state.message)],
            );
          }
          if (state is RegisterSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RootScreen.routeName,
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register Screen',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 80),
                  TextFormField(
                    controller: cubit.emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Email is required' : null,
                  ),
                  TextFormField(
                    controller: cubit.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          !cubit.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => cubit.changePasswordVisibility(),
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Password is required' : null,
                    obscureText: !cubit.isPasswordVisible,
                  ),
                  TextFormField(
                    controller: cubit.confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !cubit.isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () =>
                            cubit.changeConfirmPasswordVisibility(),
                      ),
                      labelText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value != cubit.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: !cubit.isConfirmPasswordVisible,
                  ),
                  ElevatedButton(
                    onPressed: (state is RegisterLoading)
                        ? null
                        : () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.register();
                            }
                          },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                    ),
                    child: (state is RegisterLoading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
