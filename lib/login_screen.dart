import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stunting/providers/auth_provider.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_text_form_field.dart';
import 'package:stunting/widgets/loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool hidden = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    // HIDDEN PASSWORD
    passwordHidden() async {
      setState(() {
        hidden = !hidden;
      });
    }

    // HANDLE LOGIN
    loginHandle() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/launcher', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    // HEADER
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // LOGIN TEXT
    Widget textLogin() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Masuk',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            Text(
              'Masuk untuk menggunakan aplikasi',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // // EMAIL INPUT
    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 25),
        child: CustomTextFormField(
          title: 'Email',
          hint: 'Masukkan Email',
          icon: 'assets/email_icon.svg',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            // NULL
            if (value!.isEmpty) {
              return "Masukkan email";
            }
            // VALID EMAIL
            final pattern =
                r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
            final regExp = RegExp(pattern);

            if (!regExp.hasMatch(value)) {
              return "Masukkan email yang valid";
            }
            return null;
          },
        ),
      );
    }

    // // PASSWORD INPUT
    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                cursorColor: primaryTextColor,
                controller: passwordController,
                obscureText: hidden,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Masukkan Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                  hintText: 'Masukkan Password',
                  // filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryTextColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  prefixIcon: SvgPicture.asset(
                    'assets/password_icon.svg',
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: passwordHidden,
                    child: SvgPicture.asset(
                      hidden
                          ? 'assets/eye_slash_icon.svg'
                          : 'assets/eye_icon.svg',
                      width: 18,
                      height: 18,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // BUTTON LOGIN
    Widget buttonLogin() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: CustomButton(
          text: 'Masuk',
          color: primaryColor,
          press: () {
            if (formkey.currentState!.validate()) {
              loginHandle();
            }
          },
        ),
      );
    }

    // BUTTON LOGIN
    Widget buttonLoading() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  header(),
                  textLogin(),
                  emailInput(),
                  passwordInput(),
                  isLoading ? buttonLoading() : buttonLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
