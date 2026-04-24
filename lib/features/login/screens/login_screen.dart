import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/login/controller/login_cubit.dart';
import 'package:talabat_like_app/features/login/controller/login_state.dart';
import 'package:talabat_like_app/register/screens/register_screen.dart';
import 'package:talabat_like_app/view/root_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            showAboutDialog(
              context: context,
              barrierDismissible: true,
              children: [Text(state.message)],
            );
          }
          if (state is LoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RootScreen.routeName,
              (_) => false,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
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
                    'Login Screen',
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
                        onPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        icon: (!cubit.isPasswordVisible)
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                    obscureText: !cubit.isPasswordVisible,
                    validator: (value) =>
                        value!.isEmpty ? 'Password is required' : null,
                  ),
                  ElevatedButton(
                    onPressed: (state is LoginLoading)
                        ? null
                        : () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },

                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                    ),
                    child: (state is LoginLoading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(RegisterScreen.routeName);
                        },
                        child: Text('Register'),
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
