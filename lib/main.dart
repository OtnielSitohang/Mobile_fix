import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Pages/login_page.dart';
import 'Config/global.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';

//*State
import 'Bloc/app/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // darkTheme: themeConfig.themeDark,
            home: const LoginPage(),
            routes: routesApp,
          );
        },
      ),
    );
  }
}
