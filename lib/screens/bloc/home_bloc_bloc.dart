import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/models/news_data_model.dart';
import 'package:news_app/data/repositories/news_data_repository.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final NewsDataRepository newsRepository;
  HomeBlocBloc(this.newsRepository) : super(HomeBlocInitial()) {
    on<FetchDataFromApiEvent>(fetchDataFromApiEvent);
  }

  FutureOr<void> fetchDataFromApiEvent(
      FetchDataFromApiEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeBlocLoading());
    print("in bloc");
    final newsData = await newsRepository.fetchNews();
    emit(HomeBlocSuccess(newsModel: newsData));
    return;
    try {} catch (e) {
      emit(HomeBlocError(error: e.toString()));
    }
  }
}
