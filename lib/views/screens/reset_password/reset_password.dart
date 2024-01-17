part of 'reset_password_imports.dart';

class ResetPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              SigningCubit.clearControllers();
              Navigator.pop(context);
            },
            icon: IconShadowWidget(
              Icon(
                CupertinoIcons.back,
                color: Colors.indigo,
                size: 28,
              ),
            )),
        title: CustomText(
          text: 'Reset password',
          textStyle: TextStyle(
              color: Colors.indigo,
              shadows: [Shadow(color: Colors.indigo, blurRadius: 2)]),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ResponsiveBuilder(
              builder: (context, deviceInfo) => Background(
                isTopImageFound: false,
                image: "assets/images/reset_password.jpg",
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: 'Enter your Email',
                        validate: context.read<SigningCubit>().emailValidation,
                        textColor: Colors.indigo,
                        fieldColor: Colors.blue.shade100,
                        icon: Icons.email,
                        controller: SigningCubit.email,
                        hasValidate: true,
                        keyBoardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: BlocBuilder<SigningCubit, SigningState>(
                          builder: (context, state) {
                            return CupertinoButton(
                              borderRadius: BorderRadius.circular(45),
                              color: Colors.indigo,
                              // padding: EdgeInsets.all(),
                              child: Container(
                                height: deviceInfo.localHeight * .05,
                                width: deviceInfo.localWidth * .5,
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: 'Send reset link',
                                  textColor: MaterialData.kPrimaryLightColor,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  context
                                      .read<SigningCubit>()
                                      .sendResetPasswordMail(
                                          email: SigningCubit.email.text.trim(),
                                          context: context);
                                }
                              },
                            );
                          },
                        ),
                      ),
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
