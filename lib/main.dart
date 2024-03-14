import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pages/homepage/home_page.dart';
import 'package:pokedex/pages/homepage/homepage_bloc.dart';
import 'package:pokedex/pages/homepage/homepage_event.dart';
import 'package:pokedex/pages/pokemonForm/pokemonform_bloc.dart';
import 'package:pokedex/services/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(SQLHelper())..add(FetchPokemonEvent())), // Initialize HomeBloc
        BlocProvider<PokemonFormBloc>(create: (context) => PokemonFormBloc(SQLHelper())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home:const HomePage()

      ),
    );
  }
}

