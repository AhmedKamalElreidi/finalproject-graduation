part of 'signing_cubit.dart';

@immutable
abstract class SigningState {}

class SigningInitial extends SigningState {}

class SigningLoading extends SigningState {}

class SigningDone extends SigningState {
  final User user;

  SigningDone(this.user);
}

class SigningFailed extends SigningState {
  final String error;

  SigningFailed(this.error);
}
class NoSignedAccount extends SigningState {}
class EmailVerified extends SigningState {}
class EmailNotVerified extends SigningState {}
