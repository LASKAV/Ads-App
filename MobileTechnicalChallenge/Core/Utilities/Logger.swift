import Foundation

enum LogLevel: String {
    case info = "ℹ️"
    case warning = "⚠️"
    case error = "❌"
    case debug = "🐞"
}

struct Logger {
    static var isEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()

    static func log(_ message: String,
                    level: LogLevel = .info,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        guard isEnabled else { return }
        let filename = (file as NSString).lastPathComponent
        print("\(level.rawValue) [\(filename):\(line)] \(function) ➤ \(message)")
    }
}
