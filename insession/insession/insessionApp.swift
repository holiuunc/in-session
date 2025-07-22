import SwiftUI

/// The main entry point for the In-Session macOS application
@main
struct insessionApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        MenuBarExtra("In-Session", systemImage: "target") {
            if !appState.isWindowVisible {
                // Main interface when no floating window
                VStack(spacing: 0) {
                    MenuBarContentView()
                        .environmentObject(appState)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    Button("Pop Out Window") {
                        appState.enableAndShowFloatingWindow()
                    }
                    .keyboardShortcut("p", modifiers: .command)
                }
                .frame(minWidth: 350)
            } else {
                // Minimal interface when floating window is active
                Button("Hide Floating Window") {
                    appState.hideWindow()
                }
                .keyboardShortcut("i", modifiers: .command)
                .frame(minWidth: 150)
                .padding()
            }
        }
        .menuBarExtraStyle(.window)
    }
}

/// Manages the app state
class AppState: ObservableObject {
    @Published var isWindowVisible = false
    private var floatingWindow: NSWindow?
    private var allowFloatingWindow = false // Safety flag to prevent accidental creation
    
    func showFloatingWindow() {
        // Add call stack debugging to find what's calling this
        print("🚨 showFloatingWindow() called!")
        print("Call stack: \(Thread.callStackSymbols.prefix(5))")
        
        // SAFETY: Only allow floating window when explicitly enabled
        guard allowFloatingWindow else {
            print("❌ Floating window creation blocked - not explicitly enabled")
            return
        }
        
        // Safety guard: Don't create floating window if one already exists
        guard floatingWindow == nil else {
            floatingWindow?.makeKeyAndOrderFront(nil)
            isWindowVisible = true
            print("Floating window already exists, bringing to front")
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
        
        // Center on screen but offset slightly to avoid overlap
        window.center()
        var frame = window.frame
        frame.origin.y -= 50 // Move down to avoid menu bar area
        window.setFrame(frame, display: true)
        window.makeKeyAndOrderFront(nil)
        
        self.floatingWindow = window
        self.isWindowVisible = true
        
        print("Created new floating window")
    }
    
    func hideWindow() {
        floatingWindow?.orderOut(nil)
        floatingWindow = nil // Clear the reference
        self.isWindowVisible = false
        allowFloatingWindow = false // Reset permission when hiding
        print("Hiding floating window")
    }
    
    /// Explicitly enables and shows floating window (user action only)
    func enableAndShowFloatingWindow() {
        print("✅ User explicitly requested floating window")
        allowFloatingWindow = true
        showFloatingWindow()
    }
    
    /// Ensures only one window system is active at a time
    func resetWindowState() {
        if isWindowVisible {
            hideWindow()
        }
        allowFloatingWindow = false // Reset permission
        print("Window state reset")
    }
}
