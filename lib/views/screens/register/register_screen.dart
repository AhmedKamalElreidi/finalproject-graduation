part of 'register_main_file.dart';

class RegisterScreen extends StatelessWidget {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveBuilder(
        builder:(context, deviceInfo) =>  Background(
         image: 'assets/images/create_account.jpg',
         child: Form(
           key: _registerFormKey,
           child: Column(
             children: [
               CustomTextFormField(
                 hintText: 'first name',
                 validate: (String name) => context
                     .read<SigningCubit>()
                     .nameValidation(name, 'first name'),
                 textColor: MaterialData.kPrimaryColor,
                 fieldColor: MaterialData.kPrimaryLightColor,
                 icon: Icons.person_pin,
                 controller: SigningCubit.firstName,
                 keyBoardType: TextInputType.name,
               ),
               CustomTextFormField(
                 keyBoardType: TextInputType.name,
                 hintText: 'last name',
                 validate: (String name) => context
                     .read<SigningCubit>()
                     .nameValidation(name, 'last name'),
                 textColor: MaterialData.kPrimaryColor,
                 fieldColor: MaterialData.kPrimaryLightColor,
                 icon: Icons.person_pin,
                 controller: SigningCubit.lastName,
               ),
               ////////////
               //Email
               /////////
               CustomTextFormField(
                 // hint:'password' ,
                 hintText: 'email',
                 isPassword: false,
                 keyBoardType: TextInputType.emailAddress,
                 validate: context.read<SigningCubit>().emailValidation,
                 textColor: MaterialData.kPrimaryColor,
                 fieldColor: MaterialData.kPrimaryLightColor,
                 icon: Icons.email,
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
                 context.read<SigningCubit>().passwordValidation,
                 // textInputType: TextInputType.visiblePassword,
                 textColor: MaterialData.kPrimaryColor,
                 fieldColor: MaterialData.kPrimaryLightColor,
                 // Theme.of(context).scaffoldBackgroundColor,
                 icon: Icons.vpn_key_sharp,
                 controller: SigningCubit.password,
               ),
               CustomTextFormField(
                 keyBoardType: TextInputType.visiblePassword,
                 hintText: 'confirm password',
                 isPassword: true,
                 validate: (String password) {
                   if (password.isNotEmpty &&
                       SigningCubit.confirmPassword.text.trim() ==
                           SigningCubit.password.text.trim())
                     return null;
                   else
                     return 'confirm password must be same as password';
                 },
                 // textInputType: TextInputType.visiblePassword,
                 textColor: MaterialData.kPrimaryColor,
                 fieldColor: MaterialData.kPrimaryLightColor,
                 // Theme.of(context).scaffoldBackgroundColor,
                 icon: Icons.vpn_key_sharp,
                 controller: SigningCubit.confirmPassword,
               ),

               ///////
               //Button
               //////
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: BlocBuilder<SigningCubit, SigningState>(
                   builder: (context, state) => CupertinoButton(
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
                         text: 'Register',
                         textColor:
                         MaterialData.kPrimaryLightColor,
                       ),
                     ),
                     onPressed: () async {
                       FocusScope.of(context).unfocus();
                       if (_registerFormKey.currentState.validate()) {
                         context
                             .read<SigningCubit>()
                             .registerWithEmailAndPassword(
                             SigningCubit.email.text,
                             SigningCubit.password.text,
                             context)
                             .then((value) {
                            if (value == null) {
                             NavigationServices.navigateTo(VerificationScreenRoute);
                           }
                         });
                       }
                     },
                   ),
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
                       text: 'Already have an account',
                       fontSize: 16,
                       textColor: MaterialData.kPrimaryColor,
                     ),
                     onTap: () {
                       SigningCubit.clearControllers();
                       Navigator.pushReplacementNamed(
                           context, '/LoginScreen');
                     }),
               )
             ],
           ),
         ),
          ),
      ),
    );
  }
}
