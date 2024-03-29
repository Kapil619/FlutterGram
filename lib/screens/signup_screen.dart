import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttergram/resources/auth_methods.dart';
import 'package:fluttergram/responsive/mobile_screen_layout.dart';
import 'package:fluttergram/responsive/responsive_layout_screen.dart';
import 'package:fluttergram/responsive/web_screen_layout.dart';
import 'package:fluttergram/screens/login_screen.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:fluttergram/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //controllers for inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!,
      );
      if (res != 'Success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
          res,
          context,
          color: Colors.red[700],
          textColor: Colors.white,
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
      setState(
        () {
          _isLoading = false;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      setState(
        () {
          _isLoading = false;
        },
      );
      showSnackBar('Complete all fields', context,
          color: Colors.red[700], textColor: Colors.white);
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Container(),
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcATop),
                  // color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 34),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png',
                            ),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 60,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                //Username field
                TextFieldInput(
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text,
                    hintText: 'Enter your username'),
                const SizedBox(height: 24),
                //Email field
                TextFieldInput(
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Enter your email'),
                const SizedBox(height: 24),
                //Password field
                TextFieldInput(
                    textEditingController: _passwordController,
                    textInputType: TextInputType.text,
                    hintText: 'Enter your password',
                    isPass: true),
                const SizedBox(height: 24),
                //Bio field
                TextFieldInput(
                    textEditingController: _bioController,
                    textInputType: TextInputType.text,
                    hintText: 'Enter your bio'),
                const SizedBox(height: 24),
                //signup btn
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Sign up'),
                  ),
                ),
                // const SizedBox(height: 12),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Container(),
                ),
                //bottom footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't  have an account? "),
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Log in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
