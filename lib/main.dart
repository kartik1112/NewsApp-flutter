import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/models/news_data_model.dart';
import 'package:news_app/data/repositories/news_data_provider.dart';
import 'package:news_app/data/repositories/news_data_repository.dart';
import 'package:news_app/screens/bloc/home_bloc_bloc.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(253, 131, 57, 0),
  ),
  textTheme: GoogleFonts.dmSansTextTheme(),
);
final lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(253, 131, 57, 0),
  ),
  textTheme: GoogleFonts.dmSansTextTheme(),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProvider(
      create: (context) => NewsDataRepository(NewsDataProvider()),
      child: BlocProvider(
          create: (context) => HomeBlocBloc(NewsDataRepository(NewsDataProvider())),
          child: MaterialApp(
            themeMode: ThemeMode.system,
            darkTheme: darkTheme,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          )),
    ),
  );
}
