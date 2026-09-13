import AppIntents
import CoreMotion

struct DetectOrientationIntent: AppIntent {
    static let title: LocalizedStringResource = "Detect iPhone Orientation"
    static let description = IntentDescription(
        "Returns the iPhone's physical orientation for use in Shortcuts conditions."
    )
    // Prefer the background for Action Button, while also allowing Shortcuts
    // to invoke the action from a foreground editing/testing environment.
    static let supportedModes: IntentModes = [
        .background,
        .foreground(.dynamic)
    ]
    static let authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed

    func perform() async throws -> some IntentResult & ReturnsValue<PhoneOrientation> {
        let orientation = await MotionOrientationReader.read()
        return .result(value: orientation)
    }
}

@MainActor
private enum MotionOrientationReader {
    static func read() async -> PhoneOrientation {
        let motionManager = CMMotionManager()
        guard motionManager.isDeviceMotionAvailable else {
            return .unavailable
        }

        // The sensor exists only for this short read. No background monitoring,
        // timers, stored state, or resident service is used.
        motionManager.deviceMotionUpdateInterval = 1.0 / 25.0
        motionManager.startDeviceMotionUpdates()
        defer { motionManager.stopDeviceMotionUpdates() }

        try? await Task.sleep(for: .milliseconds(160))
        guard let gravity = motionManager.deviceMotion?.gravity else {
            return .unavailable
        }

        return OrientationClassifier.classify(
            x: gravity.x,
            y: gravity.y,
            z: gravity.z
        )
    }
}

struct SmartButtonShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: DetectOrientationIntent(),
            phrases: [
                "Detect orientation with \(.applicationName)",
                "Get phone orientation with \(.applicationName)"
            ],
            shortTitle: "iPhone Orientation",
            systemImageName: "move.3d"
        )
    }

    static let shortcutTileColor: ShortcutTileColor = .navy
}
