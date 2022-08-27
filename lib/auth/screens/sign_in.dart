import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spice_blog_22/auth/logic/sign_in_bloc.dart';
import 'package:spice_blog_22/auth/screens/sign_up.dart';
import 'package:spice_blog_22/blogs/screens/blogs.dart';
import 'package:spice_blog_22/common/widgets/input_field.dart';
import 'package:spice_blog_22/common/widgets/vertical_spacing.dart';
import 'package:spice_blog_22/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final SignInBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SignInBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00BCD7),
      body: Padding(
        padding: EdgeInsets.symmetric(

          vertical: 48.0,
          horizontal: MediaQuery.of(context).size.width / 10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Sign In to Spice Blog',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const VerticalSpacing(),
              StreamBuilder<String?>(
                  stream: bloc.email.obs$,
                  builder: (context, snapshot) {
                    return InputField(
                      onChanged: bloc.email.addValue,
                      hintText: 'for e.g., abc@xyz.com',
                      labelText: 'Email ID',
                      errorText: snapshot.error as String?,
                    );
                  }),
              const VerticalSpacing(),
              StreamBuilder(
                  stream: bloc.password.obs$,
                  builder: (context, snapshot) {
                    return StreamBuilder<bool>(
                        stream: bloc.passwordObscure.obs$,
                        initialData: true,
                        builder: (context, obscureSnap) {
                          return InputField(
                            onChanged: bloc.password.addValue,
                            suffixIcon: InkWell(
                              child: !obscureSnap.data!
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                bloc.passwordObscure
                                    .addValue(!obscureSnap.data!);
                              },
                            ),
                            obscureText: obscureSnap.data,
                            errorText: snapshot.error as String?,
                            hintText:
                            'Must have at least one uppercase letter, one lowercase letter and one number',
                            labelText: 'Password',
                          );
                        });
                  }),
              const VerticalSpacing(),
              StreamBuilder<bool>(
                  stream: bloc.validInputObs$,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data ?? false;
                    return ElevatedButton.icon(
                      onPressed: isValid
                          ? () async {
                        if (await bloc.signIn()) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const BlogFeed()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('User not found')),
                          );
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                      icon: const Icon(Icons.login),
                      label: const Text('Sign In'),
                    );
                  }),
              const VerticalSpacing(),
              RichText(
                text: TextSpan(
                    text: 'Not a user yet?',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(
                          text: ' Sign Up ',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            }),
                      const TextSpan(text: 'instead.'),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}