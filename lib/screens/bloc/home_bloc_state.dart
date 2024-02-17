part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

final class HomeBlocSuccess extends HomeBlocState {
  final List<NewsDataModel> newsModel;

  HomeBlocSuccess({required this.newsModel});
}

final class HomeBlocLoading extends HomeBlocState {}

final class HomeBlocError extends HomeBlocState {
  final String error;

  HomeBlocError({required this.error});
}
