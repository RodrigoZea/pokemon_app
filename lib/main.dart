import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_app/core/providers.dart';
import 'package:pokemon_app/presentation/pages/home_page.dart';
import 'package:pokemon_app/presentation/pages/landing_page.dart';
import 'package:pokemon_app/presentation/pages/pokemon_detail_page.dart';

/// Configuración de Router
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext builder, GoRouterState state) {
        return const LandingPage();
      },
      routes: [
        GoRoute(
          path: 'home',
          builder: (BuildContext builder, GoRouterState state) {
            return const HomePage();
          },
          routes: [
            GoRoute(
              name: 'detail',
              path: 'detail/:name',
              builder: (BuildContext builder, GoRouterState state) {
                
                return PokemonDetailPage(
                  name: state.pathParameters['name'] ?? ''
                );
              }
            )
          ]
        )
      ]
    ),
  ]
);

/// Configuración de cliente de GraphQL
final HttpLink httpLink = HttpLink(
    'https://graphql-pokeapi.graphcdn.app/'
  );

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache()
  )
);


/// App
/// 
/// App principal. Debe estar encapsulada dentro de ambos el proveedor de GraphQL y el router. 
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

/// Encargado de correr el app principal. Se realiza el overrideWithValue para reemplazar el valor en 'lib/core/providers.dart'
void main() async {
  runApp(ProviderScope(
    overrides: [
      clientProvider.overrideWithValue(client),
    ],
    child: const App(),
  ));
}
