import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_app/core/providers.dart';
import 'package:pokemon_app/presentation/pages/home_page.dart';
import 'package:pokemon_app/presentation/pages/landing_page.dart';
import 'package:pokemon_app/presentation/pages/pokemon_detail_page.dart';

/* Configuración de router y rutas */
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext builder, GoRouterState state) {
        return const LandingPage();
      }
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext builder, GoRouterState state) {
        return const HomePage();
      }
    ),
    GoRoute(
      path: '/detail',
      builder: (BuildContext builder, GoRouterState state) {
        String name = state.extra as String;
        return PokemonDetailPage(name: name);
      }
    )
  ]
);

final HttpLink httpLink = HttpLink(
    'https://graphql-pokeapi.graphcdn.app/'
  );

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache()
  )
);


// Declaración de app principal 
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return GraphQLProvider(
      client: client,
      child: MaterialApp.router(
        routerConfig: _router,
      )
    );
  }
}

// Correr app
void main() async {
  runApp(ProviderScope(
    overrides: [
      clientProvider.overrideWithValue(client),
    ],
    child: const App(),
  ));
}
