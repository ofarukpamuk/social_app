import 'package:flutter/material.dart';
import 'package:kursgirissayfasifirebase/app/sign_in/sign_in_page.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import '../viewmodel/user_view_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.state == ViewState.IDLE) {
      if (userViewModel.userModel == null) {
        return const SignInPage();
      } else {
        return HomePage(userModel: userViewModel.userModel);
      }
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
