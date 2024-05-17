# ai_widget_catalog

A rough prototype for an AI powered widget catalog. This tool is built as a
Flutter DevTools extension, which is a Flutter web app that can be embedded
directly in DevTools or in the IDE by the DevTools extensions framework.

## How to use this extension as a tool in your IDE

Since this package is unpublished at the moment, follow these steps to use this
DevTools extension as an embedded tool in VS Code:

1. Clone this repository.
2. Open a Flutter project in VS Code, and add a path dependency on the `ai_theme_builder` 
package.
```yaml
dev_dependencies:
  ai_widget_catalog:
    path: ../path/to/ai_widget_catalog
```
3. Run `flutter pub get`.
4. Open the Flutter sidebar in VS Code, and you will see the extension listed there. If
for some reason this does not work, reload the VS Code window.

## API Key

To use this tool or to develop this tool, you will need an API key from
Google AI Studio. See the
[Gemini Quickstart](https://ai.google.dev/gemini-api/docs/quickstart?lang=dart)
docs for more information.

## Development

You will need to pass in your API key on app run (or temporarily hardcode it)
if you plan to develop this tool.

```
flutter run -d chrome \
--dart-define=GOOGLE_AI_API_KEY=your-api-key-here \
--dart-define=use_simulated_environment=true
```

Consider adding this launch configuration in VS Code for ease of development:

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "ai_widget_catalog",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define=GOOGLE_AI_API_KEY=your-api-key-here",
                "--dart-define=use_simulated_environment=true",
            ],
        },
        {
            "name": "ai_widget_catalog (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "ai_widget_catalog (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}
```
