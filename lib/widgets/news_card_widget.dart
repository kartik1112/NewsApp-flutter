import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/bloc/home_bloc_bloc.dart';
import 'package:lottie/lottie.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is HomeBlocSuccess) {
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
                  CachedNetworkImage(
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    errorWidget: (context, url, error) => Lottie.network(height: 50,width:50,"https://lottie.host/bd6aadad-c911-4ae2-a4e5-77ab61c0f013/PlNCeCDrUc.json"),
                    placeholder: (context, url) =>
                        Lottie.network("https://lottie.host/41a56c0d-2bf6-4325-9a47-0af60e4c2688/sbOgcmYPJe.json"),
                    imageUrl: state.newsModel[index].imageUrl?? "Invalid Value",
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
        } else {
          return ErrorWidget("exception");
        }
      },
    );
  }
}
