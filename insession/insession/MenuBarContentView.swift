import SwiftUI

/// The main content view for the MenuBarExtra - implements the liquid glass pill interface
struct MenuBarContentView: View {
    @State private var sessionManager = SessionManager()
    @State private var taskDescription: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Single integrated pill container
            VStack(spacing: 8) {
                // Main controls row
                HStack(spacing: 12) {
                    // Session Control Buttons
                    SessionControlView(
                        sessionManager: sessionManager,
                        taskText: taskDescription
                    )
                    
                    // Expandable Task Input - sizes itself naturally
                    TaskInputView(
                        text: $taskDescription,
                        isDisabled: sessionManager.currentState.isActive,
                        placeholder: "What are you working on?"
                    )
                    .frame(minWidth: 200, maxWidth: 280)
                }
                
                // Integrated session status (when active)
                if sessionManager.currentState != .inactive {
                    HStack(spacing: 8) {
                        // Status indicator
                        Circle()
                            .fill(sessionManager.currentState == .active ? .green : .orange)
                            .frame(width: 6, height: 6)
                            .scaleEffect(sessionManager.currentState == .active ? 1.2 : 1.0)
                            .animation(
                                sessionManager.currentState == .active ? 
                                    .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : 
                                    .easeInOut(duration: 0.3), 
                                value: sessionManager.currentState == .active
                            )
                        
                        // Status text
                        Text(sessionManager.currentState == .active ? "Focus session active" : "Session paused")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        // Duration
                        LiveTimerView(sessionManager: sessionManager)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(.secondary)
                            .monospacedDigit()
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(.thinMaterial)
                    .opacity(0.8)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.quaternary, lineWidth: 0.5)
            )
            .animation(.easeInOut(duration: 0.2), value: taskDescription.count)
        }
        .padding(8)
        .frame(minWidth: 350, maxWidth: 500)
        .onAppear {
            // Load any existing session state
            if !sessionManager.currentTask.isEmpty {
                taskDescription = sessionManager.currentTask
            }
        }
    }

}

/// Live timer component for session duration
struct LiveTimerView: View {
    @Bindable var sessionManager: SessionManager
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var currentDuration: TimeInterval {
        _ = currentTime
        return sessionManager.getTotalSessionDuration()
    }
    
    var body: some View {
        Text(formatDuration(currentDuration))
            .contentTransition(.numericText())
            .onReceive(timer) { time in
                currentTime = time
            }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

#Preview {
    MenuBarContentView()
        .frame(width: 400, height: 60)
}

#Preview {
    MenuBarContentView()
        .frame(width: 400, height: 60)
} 