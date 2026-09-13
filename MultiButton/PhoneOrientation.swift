import AppIntents

enum PhoneOrientation: String, AppEnum {
    case topUp
    case topDown
    case leftEdgeDown
    case rightEdgeDown
    case screenUp
    case screenDown
    case unavailable

    static let typeDisplayRepresentation = TypeDisplayRepresentation(
        name: "iPhone Orientation"
    )

    static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .topUp: "Top edge up",
        .topDown: "Top edge down",
        .leftEdgeDown: "Left edge down",
        .rightEdgeDown: "Right edge down",
        .screenUp: "Screen facing up",
        .screenDown: "Screen facing down",
        .unavailable: "Could not determine"
    ]
}

enum OrientationClassifier {
    static func classify(x: Double, y: Double, z: Double) -> PhoneOrientation {
        let absoluteX = abs(x)
        let absoluteY = abs(y)
        let absoluteZ = abs(z)

        if absoluteZ >= absoluteX && absoluteZ >= absoluteY {
            return z < 0 ? .screenUp : .screenDown
        }

        if absoluteY >= absoluteX {
            return y < 0 ? .topUp : .topDown
        }

        return x < 0 ? .leftEdgeDown : .rightEdgeDown
    }
}
