# Notes for Claude (and humans)

Minimal Flutter app. Adaptive Material/Cupertino via `flutter_platform_widgets`.

## Run / build

```sh
flutter run --flavor dev
flutter run --flavor prod
flutter build apk --flavor prod --release
flutter build ios --flavor prod --no-codesign
```

Flavors: `dev` (`com.schuly.app.dev`, "Schuly DEV") and `prod` (`com.schuly.app`, "Schuly").

## Regenerate API client

The client at `lib/api/` is generated from the C# backend's OpenAPI spec.

```sh
# 1. Start backend (from src/Schuly.API): dotnet run --urls=http://localhost:5033
# 2. Refresh spec
curl -s http://localhost:5033/swagger/v1/swagger.json -o openapi.json

# 3. Regenerate
npx --yes @openapitools/openapi-generator-cli generate \
  -i openapi.json -g dart-dio -o lib/api \
  --additional-properties=pubName=schuly_api,pubLibrary=schuly_api

# 4. Build value classes
cd lib/api && dart pub get && dart run build_runner build --delete-conflicting-outputs
```

`lib/api/**` is excluded from `flutter analyze` (see `analysis_options.yaml`).

## App icons

Source: `assets/app_icon.png`. Regenerate with `dart run flutter_launcher_icons`.
