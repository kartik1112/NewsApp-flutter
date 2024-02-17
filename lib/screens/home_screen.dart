import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/bloc/home_bloc_bloc.dart';
import 'package:news_app/widgets/news_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> places = ['in', 'us', 'au'];
  @override
  void initState() {
    super.initState();
    context.read<HomeBlocBloc>().add(FetchDataFromApiEvent("in"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(builder: (context, state) {
      if (state is HomeBlocError) {
        return ErrorWidget(state.error);
      } else if (state is HomeBlocSuccess) {
        print("in success state");
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                context.read<HomeBlocBloc>().add(ChangeLocationFloatingButtonClickedEvent(context: context));
              },
              label: const Text("Change Location")),
          appBar: AppBar(
            centerTitle: true,
            title: const Text("News App"),
          ),
          body: ListView.builder(
            itemCount: state.newsModel.length,
            itemBuilder: (context, index) {
              return NewsCardWidget(
                index: index,
              );
            },
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
