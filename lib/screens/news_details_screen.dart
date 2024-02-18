import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/screens/bloc/home_bloc_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(builder: (context, state) {
      if (state is HomeBlocSuccess) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(state.newsModel[index].publisher!),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Hero(
                    tag: state.newsModel[index].title.toString(),
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.fill,
                      // height: 250,
                      width: double.infinity,
                      errorWidget: (context, url, error) => Lottie.network(
                          height: 50,
                          width: 50,
                          "https://lottie.host/bd6aadad-c911-4ae2-a4e5-77ab61c0f013/PlNCeCDrUc.json"),
                      placeholder: (context, url) => Lottie.network(
                          "https://lottie.host/41a56c0d-2bf6-4325-9a47-0af60e4c2688/sbOgcmYPJe.json"),
                      imageUrl: state.newsModel[index].imageUrl ?? "nourl",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: double.infinity),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: double.infinity),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            state.newsModel[index].description!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 30,),
                          GestureDetector(
                            onTap: () async {
                              (state.newsModel[index].url != "")
                                  ? {
                                    ScaffoldMessenger.of(context)
                                          .showSnackBar( const SnackBar(
                                        content: Text("Launching... Please Stand By"),
                                        duration: Duration(seconds: 3),
                                      )),
                                      await launchUrl(Uri.parse(
                                          state.newsModel[index].url!))
                                    }
                                  : {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("No Url Found..."),
                                        duration: Duration(seconds: 3),
                                      ))
                                    };
                            },
                            child: const Text(
                              "Read More",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
                // Expanded(child: SizedBox())
              ],
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
