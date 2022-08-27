import 'package:flutter/material.dart';
import 'package:spice_blog_22/auth/datasource/auth_repository.dart';
import 'package:spice_blog_22/auth/logic/sign_in_bloc.dart';
import 'package:spice_blog_22/auth/screens/sign_in.dart';
import 'package:spice_blog_22/blogs/screens/blogs.dart';
import 'package:web_socket_channel/io.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spice Blog',
      home: SignInBlocProvider(
        bloc: SignInBloc(),
        child: AuthRepository().currentUser == null
            ? const SignInPage()
            : const BlogFeed(),
      ),
    );
  }
}

class SignInBlocProvider extends InheritedWidget {
  final SignInBloc bloc;

  const SignInBlocProvider(
      {Key? key, required Widget child, required this.bloc})
      : super(key: key, child: child);

  static SignInBlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SignInBlocProvider>();
  }

  @override
  bool updateShouldNotify(SignInBlocProvider oldWidget) {
    return false;
  }
}