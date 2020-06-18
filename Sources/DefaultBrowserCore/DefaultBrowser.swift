public typealias BundleId = String

public struct DefaultBrowser: Equatable {
    public let bundleId: BundleId

    public var name: String {
        guard let name = bundleId.split(separator: ".").last else {
            return bundleId
        }

        return String(name)
    }

    init(bundleId: String) {
        self.bundleId = bundleId.lowercased()
    }
}

public extension DefaultBrowser {
    static var all: [DefaultBrowser] {
        LaunchServices.copyAllHandlers(for: .http).map { bundleId in
            DefaultBrowser(bundleId: bundleId)
        }
    }

    static var current: DefaultBrowser? {
        guard let bundleId = LaunchServices.copyDefaultHandler(for: .http) else {
            return nil
        }

        return DefaultBrowser(bundleId: bundleId)
    }

    func makeDefault() throws {
        try LaunchServices.setDefaultHandler(bundleId, for: .http)
    }
}
