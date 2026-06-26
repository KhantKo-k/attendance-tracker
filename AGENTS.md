# Flutter App Starter Kit with BLoC

Multi-flavor Flutter starter using **Clean Architecture**, **BLoC**, **go_router**, **Retrofit**, **injectable/GetIt**, and **Either**-based errors. Use this file to orient in the repo; follow patterns in existing features (especially `product`).

## Implemented Features

- Clean architecture (data, domain, presentation)
- Localization, Theme, Logging
- Per-flavor env (`.env.*` + `envied` → `lib/core/configurations/`)
- DI (`injectable` / `get_it`) 
- Navigation (`go_router`)
- Repository pattern, Retrofit APIs, `freezed` + `json_serializable`
- Typed error handling and reporting, refresh tokens, app security (Talsec)
- Flavors (`flavorizr` -> mock, dev, uat, preprod, prod)
- Functional programming (Either)
- State management (`flutter_bloc`)
- Push notifications (Firebase)
- Deep links
- Local storage (`hive_ce`)

## Project Structure

```
lib/
├── main.dart, app.dart, flavors.dart
├── core/           # App-wide infra: config, DI, navigation, network, error, logging, security
│   ├── configurations/
│   ├── constants/
│   ├── di/
│   ├── error/
│   ├── logging/
│   ├── navigation/
│   ├── network/
│   ├── security/
│   ├── services/
│   └── storage/
├── features/       # Vertical modules (auth, home, product, notification, profile, …)
│   ├── <feature>/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── dtos/
│   │   │   ├── mappers/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── blocs/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   ├── <feature>_routes.dart
│   │   ├── <feature>_urls.dart
│   │   └── ...
├── shared/         # Reusable UI, theme, extensions (no feature business logic)
│    ├── theme/
│    ├── utils/
│    └── widgets/
```

**Bootstrap:** `main.dart` (Firebase, env, DI, session, localization) → `app.dart` (root providers + `MaterialApp.router`) → `AppRouter` in `lib/core/navigation/`.

**Flavors:** `mock`, `dev`, `uat`, `preprod`, `prod` — set `F.appFlavor`, drive `configureDependencies(environment: …)` and `EnvConfig` via `.env.<flavor>` files at repo root.

## Task-Specific Rules and Skills

Read these rules **only when the task touches that area**:

| Task                                                   | Rule                               |
| ------------------------------------------------------ | ---------------------------------- |
| Routes, redirects, navigation helpers                  | `.cursor/rules/navigation.mdc`     |
| Exceptions, failures, API/repository errors, reporting | `.cursor/rules/error-handling.mdc` |

Use the following skills **only when the task touches that area**:

| Skill                         | File                                          |
| ----------------------------- | --------------------------------------------- |
| Update environment variables  | `.agent/skills/update-env-variables/SKILL.md` |
| Spec-driven changes           | `.cursor/skills/openspec-*.md`                |

## Coding Standards

- ALWAYS follow SOLID principles and Clean Architecture layer boundaries
- WHEN writing UI code, ALWAYS use named methods/widgets per section and never write UI code as single block inside `build` method of a widget. Callbacks, event handlers, and other logic should be placed in separate methods. The UI code should be readable from top to bottom, widgets first and followed by logic, see the example below.

**UI Code Example**

```dart
class MyWidgetState extends State<MyWidget> {
  // Local variables
  final TextEditingController _controller = TextEditingController();

  // Constructor
  const MyWidget({super.key});

  // Lifecycle methods
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Build method and child widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('My Widget'),
      actions: [
        IconButton(
          onPressed: () {
            _onActionPressed(context);
          },
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
        children: [
        _buildHeader(context),
        _buildContent(context),
        ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text('Header');
  }

  Widget _buildContent(BuildContext context) {
    return Text('Content');
  }


  // Event handlers, callbacks, etc.
  void _onActionPressed(BuildContext context) {
    print('Action pressed');
  }
}
```

## Instructions

- ALWAYS run after freezed / json / retrofit / injectable / envied changes:

```bash
dart run build_runner clean
dart run build_runner build
```

- NEVER edit `*.g.dart`, `*.freezed.dart`, `service_locator.config.dart`, or generated env/API files.
