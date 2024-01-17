part of 'login_main_file.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ResponsiveBuilder(
              builder: (context, deviceInfo) => Background(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ////////////
                      //Email
                      /////////
                      CustomTextFormField(
                        // hint:'password' ,
                        hintText: 'email',
                        keyBoardType: TextInputType.emailAddress,
                        isPassword: false,
                        validate: context.read<SigningCubit>().emailValidation,
                        textColor: MaterialData.kPrimaryColor,
                        fieldColor: MaterialData.kPrimaryLightColor,
                        icon: Icons.person,
                        controller: SigningCubit.email,
                      ),
                      ////
                      //Password
                      ///
                      CustomTextFormField(
                        keyBoardType: TextInputType.visiblePassword,
                        // hint:'password' ,
                        hintText: 'password',
                        isPassword: true,
                        validate:
                            context.watch<SigningCubit>().passwordValidation,

                        // textInputType: TextInputType.visiblePassword,
                        textColor: MaterialData.kPrimaryColor,
                        fieldColor: MaterialData.kPrimaryLightColor,
                        // Theme.of(context).scaffoldBackgroundColor,
                        hasValidate: true,
                        icon: Icons.vpn_key_sharp,
                        controller: SigningCubit.password,
                      ),
                      ///////
                      //Button
                      //////
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BlocBuilder<SigningCubit, SigningState>(
                          builder: (context, state) {
                            return CupertinoButton(
                              borderRadius: BorderRadius.circular(45),
                              color: MaterialData.kPrimaryColor,
                              // padding: EdgeInsets.all(),
                              child: Container(
                                height: deviceInfo.localHeight * .05,
                                width: deviceInfo.localWidth * .5,
                                alignment: Alignment.center,
                                child: state is SigningLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              MaterialData.kPrimaryLightColor),
                                        ),
                                      )
                                    : CustomText(
                                        text: 'Login',
                                        textColor:
                                            MaterialData.kPrimaryLightColor,
                                      ),
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState.validate()) {
                                  context
                                      .read<SigningCubit>()
                                      .loginWithEmailAndPassword(
                                          SigningCubit.email.text,
                                          SigningCubit.password.text,
                                          context)
                                      .then((value) {
                                    if (value == null) {
                                      if(context.read<SigningCubit>().firebaseAuth.currentUser.emailVerified)
                                  {
                                    NavigationServices
                                        .navigateToWithReplacementRemovedUntil(
                                        MainScreenRoute);
                                  }
                                      else{
                                        NavigationServices
                                            .navigateTo(
                                       VerificationScreenRoute     );
                                      }
                                      // Navigator.pushNamedAndRemoveUntil(context,
                                      // '/MainScreen', (route) => false);
                                    }
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: CustomText(
                            text: 'Forget password',
                            textColor: MaterialData.kPrimaryColor,
                            fontSize: 16,
                          ),
                          onTap: () {
                            SigningCubit.clearControllers();
                            NavigationServices.navigateTo(ResetPasswordRoute);
                          },
                        ),
                      ),

                      ///OR
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: MaterialData.kPrimaryColor,
                          )),
                          CustomText(
                            text: '  OR  ',
                            textColor: MaterialData.kPrimaryColor,
                          ),
                          Expanded(
                              child: Divider(
                            color: MaterialData.kPrimaryColor,
                          )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          child: CustomText(
                            text: 'Create new account',
                            textColor: MaterialData.kPrimaryColor,
                            fontSize: 16,
                          ),
                          onTap: () {
                            SigningCubit.clearControllers();

                            Navigator.pushReplacementNamed(
                                context, '/RegisterScreen');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
