import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit() : super(RecommendationInitial());
  String unitType;
  double budget = 500000.0;
  void changeBudget(double newValue) {
    budget = newValue;
    emit(RecommendationUpdated());
  }

  void changeUnitType(String value) {
    unitType = value.toLowerCase();
    emit(RecommendationUpdated());
  }

  // void deleteFromDatabase(String uid) async {
  //   await recommendBox.delete(uid);
  // }
  //
  // void initializeData(Box<double> box) async {
  //   recommendBox = box;
  //   // isMarried =
  //   //     box.get(FirebaseAuth.instance.currentUser.uid).isMarried ?? false;
  //   // hasChildren =
  //   //     box.get(FirebaseAuth.instance.currentUser.uid).hasChildren ?? false;
  //   // childNeed = box.get(FirebaseAuth.instance.currentUser.uid).childNeeds;
  //
  //   budget = box.get(FirebaseAuth.instance.currentUser.uid) ?? 50000;
  // }

  // @override
  // Future<Function> close() {
  //   recommendBox.close();
  //   Hive.close();
  //   return super.close();
  // }
}
