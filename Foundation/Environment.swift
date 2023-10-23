import Foundation

enum Obscured {
    case no
    case lightly // Dim light, patchy fog, etc.
    case heavily // Darkness, opaque fog, dense foilage - Blocks vision within
}

// The presence or absence of light
enum Light {
    case bright
    case dim
    case dark
}

/// Check if a creature can hide. Hiding is determined by `Light`, whether you are `Obscured` (wall / bush / etc), or if another creature is looking directly at you.
func hide() -> Bool {
    true
}
