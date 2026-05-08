# Poke API

Aplicación móvil hecha en **Flutter** que consume la [PokeAPI](https://pokeapi.co/) para listar Pokémon, ver su detalle, marcar favoritos (con persistencia local) y explorar su descripción y cadena de evolución.

El proyecto está organizado bajo **Clean Architecture** con separación estricta de capas (`domain`, `data`, `presentation`), inyección de dependencias manual y `Provider` como mecanismo de gestión de estado.

---

## Funcionalidades

- Listado paginado de Pokémon desde `https://pokeapi.co/api/v2/pokemon/`.
- **Lazy loading / scroll infinito**: la siguiente página se carga automáticamente al acercarse al final de la lista.
- **Buscador local** que filtra por nombre en tiempo real sobre los Pokémon ya cargados.
- **Modal de detalle** con sprite SVG, tipos, peso, altura y stats base.
- **Descripción / flavor text** desde `/pokemon-species` (con preferencia al idioma español, fallback a inglés).
- **Cadena de evolución** desde `/evolution-chain` (incluye ramificaciones tipo Eevee).
- **Favoritos persistentes** con `shared_preferences` (sobreviven al reinicio).
- Pantalla dedicada para ver únicamente los Pokémon favoritos.

---

## Arquitectura

```
lib/
├── core/
│   ├── error/                   # Exceptions (capa data) + Failures (capa domain)
│   └── constants/api_endpoints.dart
├── features/pokemon/
│   ├── domain/                  # Puro Dart: sin Flutter, sin http
│   │   ├── entities/            # Pokemon, PokemonPage, PokemonSpecies, EvolutionStage
│   │   ├── repositories/        # PokemonRepository (contrato abstracto)
│   │   └── usecases/            # GetPokemonList, LoadMorePokemons, GetPokemonDetail,
│   │                            # GetPokemonSpecies, GetEvolutionChain,
│   │                            # ToggleFavorite, GetFavorites
│   ├── data/
│   │   ├── models/              # DTOs con fromJson
│   │   ├── datasources/         # Remote (http) + Local (SharedPreferences)
│   │   └── repositories/        # PokemonRepositoryImpl
│   └── presentation/
│       ├── providers/           # PokemonProvider (ChangeNotifier)
│       ├── screens/             # pokemon_search_screen, favorites_screen
│       ├── widgets/             # Componentes presentacionales
│       └── utils/app_colors.dart
├── injection_container.dart     # AppDependencies.bootstrap() — DI manual
└── main.dart
```

**Regla de dependencias**: `presentation → domain ← data`. La capa `domain` no importa Flutter, `http` ni ningún paquete externo, lo que la hace independiente del framework y trivialmente testeable.

---

## Tecnologías

| Paquete              | Uso                                                       |
| -------------------- | --------------------------------------------------------- |
| `http`               | Cliente HTTP para consumir la PokeAPI                     |
| `provider`           | Gestión de estado (`ChangeNotifier`)                      |
| `flutter_svg`        | Renderizado de sprites SVG (la API devuelve SVG)          |
| `flutter_speed_dial` | FAB expansible para acceder a favoritos                   |
| `shared_preferences` | Persistencia local de favoritos                           |

SDK requerido: Dart `^3.8.1` / Flutter estable.

---

## Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado y en el `PATH`.
- Para compilar a Android: Android Studio + un dispositivo o emulador con depuración USB activa.
- Para compilar a iOS: macOS con Xcode.

Validar el entorno con:

```bash
flutter doctor
```

---

## Instalación y ejecución

```bash
flutter pub get
flutter run
```

Para elegir un dispositivo específico:

```bash
flutter devices              # lista los disponibles
flutter run -d <device-id>   # corre en el dispositivo elegido
```

---

## Compilar APK para Android

Versión release split por arquitectura (recomendada para celulares modernos):

```bash
flutter build apk --release --split-per-abi
```

Los APKs se generan en `build/app/outputs/flutter-apk/`. Para casi cualquier Android moderno se usa `app-arm64-v8a-release.apk`.

Versión release única (universal, más pesada):

```bash
flutter build apk --release
```

---

## Otros comandos útiles

```bash
flutter analyze     # análisis estático con flutter_lints
flutter test        # ejecuta tests (no hay tests aún)
flutter clean       # limpia build/ y .dart_tool/
```

---

## API y créditos

Datos servidos por [PokeAPI](https://pokeapi.co/) — API REST pública y gratuita, sin autenticación. Los sprites de la cadena de evolución se sirven desde el repositorio público [PokeAPI/sprites](https://github.com/PokeAPI/sprites).
