# tmignore

Time Machine on macOS is a highly useful tool for creating backups of all your files. Unfortunately for developers, it also backs up your coding project's dependencies, build output and other undesired files, which slows down the backup process and takes up storage.

**`tmignore` excludes files and directories matched by `.gitignore` files from future Time Machine backups.**

## Install

macOS 10.13+ is required to run `tmignore`.

1. Build and install the script using Homebrew (Xcode/Swift is required):

   ```sh
   brew install matiaspuhakka/tap/tmignore
   ```

2. Alternatively, build locally using SwiftPM:

   ```sh
   make build
   ./bin/tmignore run
   ```

3. If you want to run the script once:

   ```sh
   tmignore run
   ```

   To schedule the script to run once a day:

   ```sh
   brew services start tmignore
   ```

Alternatively, if you don't want to build the binary yourself, you can download the compiled program on the [Releases](https://github.com/matiaspuhakka/tmignore/releases/latest) page.

Note: This fork does not publish a separate Homebrew formula outside `matiaspuhakka/tap`. If you prefer not to use Homebrew, follow the SwiftPM build instructions above or download a release binary.

## Commands

- **`run`:** Searches the disk for files/directories ignored by Git and excludes them from future Time Machine backups
- **`list`:** Lists all files/directories that have been excluded by `tmignore`
- **`reset`:** Removes all backup exclusions that were made using `tmignore`

## Configuration

You can configure the behavior of `tmignore` by creating a configuration file at `~/.config/tmignore/config.json`:

- **`"searchPaths"`:** Directories which should be scanned for Git repositories. Default: `["~"]` (home directory)

- **`"ignoredPaths"`:** Directories which should be excluded from the Git repository search. Default: `["~/.Trash", "~/Applications", "~/Downloads", "~/Library", "~/Music/iTunes", "~/Music/Music", "~/Pictures/Photos\\ Library.photoslibrary"]`

- **`"whitelist"`:** Files/directories which should be included in backups, even if they are matched by a `.gitignore` file. Useful e.g. for configuration or password files. Default: `[]`

**Configuration example:**

```json
{
  "searchPaths": ["~", "/path/to/another/drive"],
  "whitelist": ["*/application.yml", "*/config.json", "*/.env.*"]
}
```

## Contributing

Suggestions and contributions are always welcome! Please discuss larger changes via issue before submitting a pull request.

## Credits

Created by [Samuel Meuli](https://github.com/samuelmeuli). This repository is a maintained fork.
