// import 'dart:developer';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/form_submission_status.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:gofid_mobile_fix/Components/component.dart';
import 'package:gofid_mobile_fix/Models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: createAppBar('Login'), body: _loginForm(context));
  }

  //* Form Login
  Widget _loginForm(BuildContext context) {
    //* BlocListener
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          //* Gagal Login show snackbar
          _showSnackBar(
              context, 'Gagal Login, Periksa kembali username dan password');
        }
      },
      //*BlocBuilder
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(30),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  //*core page
                  logoGofit(context),
                  const UsernameField(),
                  const PasswordField(),
                  LoginButton(formkey: _formKey),
                  //*end core page
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  //* Methods
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //* Widget Logo Gofit
  SizedBox logoGofit(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 1 / 3,
        child: Image.asset('assets/images/icon.png'));
  }
} //* Akhir dari class

class UsernameField extends StatelessWidget {
  const UsernameField({
    Key? key,
  }) : super(key: key);

  //* Bloc Builder for the validation
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
            //* enable jika tidak lagi proses submitting
            enabled: state.formStatus is! FormSubmitting?,
            //* Styling
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Username /ID Member',
              labelText: 'Name',
            ), //*akhir dari styling
            //* validator (cek state)
            validator: (value) =>
                state.isValidUsername ? null : 'Username tidak boleh kosong',
            //* setiap perubahan add event
            onChanged: (value) {
              context
                  .read<LoginBloc>()
                  .add(LoginUsernameChanged(EMAIL_USER: value));
            });
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool statusShow = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        //* enable jika tidak sedang proses submitting
        enabled: state.formStatus is! FormSubmitting?,
        //* show / hidden password via eyes
        obscureText: statusShow,
        //*stylign
        decoration: InputDecoration(
          suffixIcon: eyeIcon(),
          icon: const Icon(Icons.password),
          hintText: 'Password',
          labelText: 'Password',
        ),
        //* akhir dari styling
        //*validasi
        validator: (value) =>
            state.isValidPassword ? null : 'Password tidak boleh kosong',
        //* mencatat perubahan ke dalam state
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(PASSWORD_USER: value)),
      );
    });
  }

  IconButton eyeIcon() {
    return IconButton(
        onPressed: () {
          setState(() {
            statusShow = !statusShow;
          });
        },
        icon: Icon((statusShow) ? Icons.visibility : Icons.visibility_off));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.formkey});

  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, loginState) {
        if (loginState.formStatus is SubmissionSuccess) {
          // inspect(loginState);
          if (loginState.user != null) {
            if (loginState.user?.ID_MEMBER != null) {
              Navigator.pushReplacementNamed(context, '/homeMember');
            } else if (loginState.user!.ID_PEGAWAI != null) {
              Navigator.pushReplacementNamed(context, '/homePegawai');
            } else if (loginState.user!.ID_INSTRUKTUR != null) {
              Navigator.pushReplacementNamed(context, '/homeInstruktur');
            }
          }
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                );
        },
      ),
    );
  }
}




// * Button Login Code Awal
// class LoginButton extends StatelessWidget {
//   const LoginButton({Key? key, required this.formkey});

//   final GlobalKey<FormState> formkey;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, loginState) {
//         if (loginState.formStatus is SubmissionSuccess) {
//           context.read<AppBloc>().add(SaveUserInfo(
//                 user: loginState.user,
//                 instruktur: loginState.instruktur,
//                 member: loginState.member,
//               ));

//           if (loginState.user?.ID_MEMBER != null) {
//             Navigator.pushReplacementNamed(context, '/homeMember');
//           } else if (loginState.user?.ID_PEGAWAI != null) {
//             Navigator.pushReplacementNamed(context, '/homePegawai');
//           } else if (loginState.user?.ID_INSTRUKTUR != null) {
//             Navigator.pushReplacementNamed(context, '/homeInstruktur');
//           }
//         }
//       },
//       child: BlocBuilder<LoginBloc, LoginState>(
//         builder: (context, state) {
//           return state.formStatus is FormSubmitting
//               ? const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 20),
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (formkey.currentState!.validate()) {
//                           context.read<LoginBloc>().add(LoginSubmitted());
//                         }
//                       },
//                       child: const Text('Login'),
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
