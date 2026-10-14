// Toggle Ghostty visibility. Called by Karabiner on ctrl+space.
// Replaces Ghostty's global toggle_visibility, which checks "is active" before
// "is hidden" and can get stuck hidden until another app is clicked.
// Build: swiftc -O toggle-ghostty.swift -o toggle-ghostty
import AppKit

let bundleID = "com.mitchellh.ghostty"

guard let app = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID).first else {
    fatalError("Ghostty is not running")
}

if app.isActive && !app.isHidden {
    app.hide()
    exit(0)
}

// After hide(), macOS can leave Ghostty active while hidden. LaunchServices
// then treats it as already in front and does not unhide it, so unhide first.
app.unhide()

// Activate through LaunchServices. A direct activate() from a background
// process can be refused by macOS.
guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) else {
    fatalError("Cannot find Ghostty.app")
}
let config = NSWorkspace.OpenConfiguration()
config.activates = true
let done = DispatchSemaphore(value: 0)
NSWorkspace.shared.openApplication(at: url, configuration: config) { _, error in
    if let error { fatalError("Cannot open Ghostty: \(error)") }
    done.signal()
}
done.wait()
