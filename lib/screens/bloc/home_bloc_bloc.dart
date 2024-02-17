import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/news_data_model.dart';
import 'package:news_app/data/repositories/news_data_repository.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  final Map<String, String> places = {
    'in': 'India',
    'au': "Australia",
    'us': "USA",
    'ca': "Canada",
  };
  @override
  void onChange(Change<HomeBlocState> change) {
    print(change);
    super.onChange(change);
  }

  final NewsDataRepository newsRepository;
  HomeBlocBloc(this.newsRepository) : super(HomeBlocInitial()) {
    on<FetchDataFromApiEvent>(fetchDataFromApiEvent);
    on<ChangeLocationFloatingButtonClickedEvent>(
        changeLocationFloatingButtonClickedEvent);
  }

  FutureOr<void> fetchDataFromApiEvent(
      FetchDataFromApiEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeBlocLoading());
    print("in bloc");
    final newsData = await newsRepository.fetchNews(event.country);
    emit(HomeBlocSuccess(newsModel: newsData));
    try {} catch (e) {
      emit(HomeBlocError(error: e.toString()));
    }
  }

  FutureOr<void> changeLocationFloatingButtonClickedEvent(
      ChangeLocationFloatingButtonClickedEvent event,
      Emitter<HomeBlocState> emit) {
    final context = event.context;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      context: context,
      builder: (context) => Container(
        constraints:
            const BoxConstraints(minHeight: 400, minWidth: double.infinity),
        child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(places.entries.elementAt(index).value),
                  onTap: () {
                    print(places[index]);
                    context.read<HomeBlocBloc>().add(FetchDataFromApiEvent(
                        places.entries.elementAt(index).key));
                    Navigator.pop(context);
                  });
            }),
      ),
    );
  }
}










/*

showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                  ),
                  context: context,
                  builder: (context) => Container(
                    constraints: const BoxConstraints(
                        minHeight: 400, minWidth: double.infinity),
                    child: ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(places[index]),
                              onTap: () {
                                print(places[index]);
                                context.read<HomeBlocBloc>().add(
                                    FetchDataFromApiEvent(
                                        places[index].toString()));
                                Navigator.pop(context);
                              });
                        }),
                  ),
                );

 */