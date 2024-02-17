import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screens/bloc/home_bloc_bloc.dart';
import 'package:news_app/secrets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> result = [];
  int? _selectedValue;
  final List<String> places = ['in', 'us', 'au'];
  @override
  void initState() {
    super.initState();
    print("calling api");
    context.read<HomeBlocBloc>().add(FetchDataFromApiEvent("in"));
    // getNewsData("in");
  }

  // void getNewsData(String country) async {
  //   final res = await http.get(Uri.parse(
  //       'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$newsAPIKey'));

  //   print(res.statusCode);
  //   final Map<String, dynamic> data = jsonDecode(res.body);

  //   result = data['articles'];
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(builder: (context, state) {
      if (state is HomeBlocError) {
        // state.error.printError();
        // print(state.error);
        return ErrorWidget(state.error);
      } else if (state is HomeBlocSuccess) {
        print("in success state");
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
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
                          // return Container(
                          //   width: 100,
                          //   height: 50,
                          //   color: Colors.green,
                          // );
                          return ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(places[index]),
                              onTap: () {
                                context
                                    .read<HomeBlocBloc>()
                                    .add(FetchDataFromApiEvent(places[index]));
                                Navigator.pop(context);
                              });
                        }),
                  ),
                );
              },
              label: const Text("Change Location")),
          appBar: AppBar(
            centerTitle: true,
            title: const Text("News App"),
          ),
          body: ListView.builder(
            itemCount: state.newsModel.length,
            itemBuilder: (context, index) {
              // String imageuri = (result[index]['urlToImage'] != null)
              //     ? result[index]['urlToImage']
              //     : "https://static.toiimg.com/thumb/msid-107676957,width-1070,height-580,imgsize-30480,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg";
              // String publisher = (result[index]['source']['name'] != null)
              //     ? result[index]['source']['name']
              //     : "null piublisher";
              // String author = (result[index]['author'] != null)
              //     ? result[index]['author']
              //     : "null author";
              // String title = (result[index]['title'] != null)
              //     ? result[index]['title']
              //     : "null title";
              // return Container(
              //   width: 100,
              //   height: 50,
              //   color: Colors.primaries[index],
              // );

              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.secondaryContainer),
                constraints: const BoxConstraints(maxHeight: double.infinity),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeInImage.assetNetwork(
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                        placeholder: state.newsModel[index].imageUrl!,
                        image: state.newsModel[index].imageUrl!,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.primary),
                        softWrap: true,
                        "Publisher - ${state.newsModel[index].publisher}",
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          state.newsModel[index].title!,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.tertiary),
                        "Author - ${state.newsModel[index].author!}",
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
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
