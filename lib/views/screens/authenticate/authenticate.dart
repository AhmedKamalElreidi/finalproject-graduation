part of 'authenticate_main_file.dart';

class Authenticate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        } else {
           if (userSnapshot.data == null) {
            return LoginScreen();
          } else {
            final user = userSnapshot.data;
            if (user.emailVerified) {
              return MainScreen();
            } else {
              return VerificationScreen();
            }
          }
        }
      },
    );

  }


}
/*  Future<bool> isLoggedIn() async {
    User user = auth.currentUser;
    if (user == null) {
      return null;
    }
    return user.emailVerified;
  }*/

