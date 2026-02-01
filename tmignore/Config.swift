import Foundation

enum ConfigError: Error {
	case parseFailed
}

private struct ConfigFile: Codable {
	let searchPaths: [String]?
	let ignoredPaths: [String]?
	let whitelist: [String]?
}

/// Responsible for parsing and storing values of the script's configuration file.
class Config {
	let configPath = NSString(string: "~/.config/tmignore/config.json").expandingTildeInPath
	private var configFile: ConfigFile?
	private let fileManager = FileManager.default

	// Directories which should be scanned for Git repositories.
	let searchPathsDefault = ["~"]
	var searchPaths: [String] {
		let searchPathsStrings = configFile?.searchPaths ?? searchPathsDefault
		return searchPathsStrings.map { expandTilde($0) }
	}

	// Directories which should be excluded from the Git repository search.
	let ignoredPathsDefault = [
		"~/.Trash",
		"~/Applications",
		"~/Downloads",
		"~/Library",
		"~/Music/iTunes",
		"~/Music/Music",
		"~/Pictures/Photos\\ Library.photoslibrary",
	]
	var ignoredPaths: [String] {
		let ignoredPathsStrings = configFile?.ignoredPaths ?? ignoredPathsDefault
		return ignoredPathsStrings.map { expandTilde($0) }
	}

	// Files/directories which should be included in backups, even if they are matched by a
	// `.gitignore` file. Useful e.g. for configuration or password files.
	let whitelistDefault = [String]()
	var whitelist: [String] {
		let whitelistPathsStrings = configFile?.whitelist ?? whitelistDefault
		return whitelistPathsStrings.map { expandTilde($0) }
	}

	/// Parses the cache file (if it exists) and saves its contents.
	init() throws {
		if let jsonData = fileManager.contents(atPath: configPath) {
			do {
				configFile = try JSONDecoder().decode(ConfigFile.self, from: jsonData)
			} catch {
				logger.error("Could not parse config file: \(error.localizedDescription)")
				throw ConfigError.parseFailed
			}
		} else {
			logger.debug("No config file found at \(configPath)")
		}
	}

	private func expandTilde(_ path: String) -> String {
		NSString(string: path).expandingTildeInPath
	}
}
