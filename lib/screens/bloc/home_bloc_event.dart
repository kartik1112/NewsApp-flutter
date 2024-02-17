part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class FetchDataFromApiEvent extends HomeBlocEvent {
  final String country;
  FetchDataFromApiEvent(this.country);
}
