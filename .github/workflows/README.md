# GitHub Actions Workflows for Schuly

This directory contains GitHub Actions workflows for automating the build and release process of the Schuly Flutter application.

## Workflows

### 1. Release Drafter (`release-drafter.yml`)
- **Trigger**: Pushes to main branch and closed pull requests
- **Purpose**: Automatically creates and updates draft releases based on merged PRs
- **Features**:
  - Semantic version resolution (major/minor/patch)
  - Automatic PR labeling based on conventional commit messages
  - Categorized changelog generation
  - Download links for all platform builds

### 2. Build and Release (`build-and-release.yml`)
- **Trigger**: Published releases and manual workflow dispatch
- **Purpose**: Builds Flutter apps for all supported platforms and attaches them to releases

## Platform Support

The workflow builds Schuly for the following platforms:

### Mobile
- **Android**: APK and App Bundle (AAB) formats
- **iOS**: IPA file (unsigned, for development/testing)

### Desktop
- **Windows**: Executable bundle (ZIP)
- **macOS**: App bundle (ZIP)
- **Linux**: Binary bundle (tar.gz)

### Web
- **Web**: Static web files (ZIP)

## How It Works

### Automated Release Process

1. **Development**: 
   - Make changes to the codebase
   - Create PRs with conventional commit messages (e.g., `feat: add new feature`)
   - Merge PRs to main branch

2. **Draft Release Creation**:
   - Release Drafter automatically creates/updates a draft release
   - Categorizes changes based on PR labels
   - Generates semantic version number

3. **Release Publishing**:
   - When you're ready to release, publish the draft release
   - This triggers the build workflow automatically
   - All platform builds are created in parallel
   - Built apps are automatically attached to the release

### Manual Trigger

You can also manually trigger the build process:
- Go to Actions tab → "Build and Release Flutter Apps"
- Click "Run workflow" to build all platforms

## Commit Message Conventions

The workflow uses conventional commit messages for automatic labeling:

- `feat:` → `feature` label → minor version bump
- `fix:` → `bug` label → patch version bump  
- `docs:` → `documentation` label
- `test:` → `test` label
- `!` suffix → `breaking` label → major version bump

Examples:
- `feat: add user authentication` 
- `fix: resolve login issue`
- `feat!: change API structure` (breaking change)

## Release Labels

Use these labels on PRs to control release categorization:

- `breaking`, `major` → Breaking Changes (major version)
- `feature`, `minor` → Features (minor version)
- `enhancement` → Enhancements
- `bug`, `bugfix`, `hotfix` → Bug Fixes (patch version)
- `security` → Security fixes
- `documentation`, `docs` → Documentation
- `test`, `tests` → Tests
- `skip-changelog` → Exclude from changelog

## Flutter Build Configuration

The workflow:
- Uses Flutter 3.24.x stable channel
- Installs dependencies with `flutter pub get`
- Generates app icons with `flutter_launcher_icons`
- Builds release versions for all platforms
- Creates platform-specific archives

### Build Requirements

- **Android**: Java 17 (Zulu distribution)
- **iOS**: macOS runner with Xcode
- **Windows**: Windows runner with Visual Studio
- **Linux**: Ubuntu with GTK3 development libraries
- **macOS**: macOS runner with Xcode
- **Web**: No additional requirements

## File Outputs

When a release is published, the following files are attached:

- `app-release.apk` - Android APK
- `app-release.aab` - Android App Bundle
- `schuly-ios.ipa` - iOS app (unsigned)
- `schuly-windows.zip` - Windows executable bundle
- `schuly-macos.zip` - macOS app bundle
- `schuly-linux.tar.gz` - Linux binary bundle
- `schuly-web.zip` - Web application files

## Security Notes

- iOS builds are unsigned (for development/testing only)
- For production iOS releases, you'll need code signing certificates
- Android builds are release builds but not signed for Play Store
- All builds use release configurations for optimal performance

## Troubleshooting

### Common Issues

1. **Build Failures**: Check the Actions logs for specific error messages
2. **Missing Dependencies**: Ensure `pubspec.yaml` is up to date
3. **Platform-Specific Issues**: Each platform has its own build job, so failures are isolated

### Customization

To modify the workflow:
1. Edit the YAML files in this directory
2. Adjust Flutter version, build commands, or platform support as needed
3. Update the Release Drafter configuration for different changelog formatting

## Next Steps

1. Commit these workflow files to your repository
2. Create a PR with conventional commit message
3. Merge the PR to see Release Drafter in action
4. Publish the draft release to trigger the first automated build

The system is now ready to automatically build and release your Flutter app across all platforms!