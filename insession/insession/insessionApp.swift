import SwiftUI

/// The main entry point for the In-Session macOS application
@main
struct insessionApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        MenuBarExtra("In-Session", systemImage: "target") {
            if appState.isWindowVisible {
                Button("Hide In-Session") {
                    appState.hideWindow()
                }
                .keyboardShortcut("i", modifiers: .command)
            } else {
                VStack(spacing: 0) {
                    MenuBarContentView()
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    Button("Pop Out Window") {
                        appState.showFloatingWindow()
                    }
                    .keyboardShortcut("p", modifiers: .command)
                }
                .frame(minWidth: 350)
            }
        }
        .menuBarExtraStyle(.window)
    }
}

/// Manages the app state
class AppState: ObservableObject {
    @Published var isWindowVisible = false
    private var floatingWindow: NSWindow?
    
    func showFloatingWindow() {
        guard floatingWindow == nil else {
            floatingWindow?.makeKeyAndOrderFront(nil)
            isWindowVisible = true
            return
        }
        
        // Create a floating window programmatically
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 80),
            styleMask: [.borderless, .titled], // Changed: .titled allows interaction
            backing: .buffered,
            defer: false
        )
        
        window.level = .floating
        window.isOpaque = false
        window.hasShadow = true
        window.backgroundColor = .clear
        window.isMovableByWindowBackground = true
        window.titleVisibility = .hidden // Hide the title bar but keep functionality
        window.titlebarAppearsTransparent = true
        
        // Create SwiftUI content
        let contentView = NSHostingView(rootView: MenuBarContentView())
        window.contentView = contentView
        
        // Center on screen
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        self.floatingWindow = window
        self.isWindowVisible = true
        
        print("Created floating window")
    }
    
    func hideWindow() {
        floatingWindow?.orderOut(nil)
        floatingWindow = nil // Clear the reference
        self.isWindowVisible = false
        print("Hiding floating window")
    }
}
