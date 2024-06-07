# pokemon_app

Un proyecto hecho en Flutter que consulta un API en GraphQL para obtener información de diferentes pokemones.

## Build

Para correr la aplicación en cualquier dispositivo, solamente es necesario correr el siguiente comando:

```
flutter run
```

## Tests

Para correr los tests de la aplicación, es necesario correr el siguiente comando:

```
flutter test
```

Se realizaron pruebas para los métodos del repositorio para consultar la lista de pokemones y detalles de un pokemon en específico. Para esto, se realizaron pruebas con Mockito para emular el comportamiento de pokemon_notifier (definido en core/providers.dart) y de pokemon_detail_provider (definido en providers.dart). La definición de las pruebas se puede encontrar debajo de la carpeta test.