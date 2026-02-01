import Logging

func createLogger() -> Logger {
	LoggingSystem.bootstrap { label in
		var handler = StreamLogHandler.standardOutput(label: label)
		handler.logLevel = .info
		return handler
	}
	return Logger(label: "com.matiaspuhakka.tmignore")
}
