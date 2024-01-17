part of 'recommendation_cubit.dart';

@immutable
abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationAdded extends RecommendationState {}

class RecommendationUpdated extends RecommendationState {}

class RecommendationDeleted extends RecommendationState {}
