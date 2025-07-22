import SwiftUI

/// Session control buttons with proper state management and native macOS styling
struct SessionControlView: View {
    @Bindable var sessionManager: SessionManager
    let taskText: String
    
    @State private var isHovered: Bool = false
    @State private var buttonScale: CGFloat = 1.0
    
    private var isTaskValid: Bool {
        !taskText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var buttonColor: Color {
        switch sessionManager.currentState {
        case .inactive:
            return isTaskValid ? .accentColor : .secondary
        case .active:
            return .red
        case .paused:
            return .orange
        }
    }
    
    private var buttonText: String {
        sessionManager.currentState.displayName
    }
    
    var body: some View {
        HStack(spacing: 8) {
            // Main action button
            Button(action: handleMainAction) {
                Text(buttonText)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(sessionManager.currentState == .inactive ? 
                                   (isTaskValid ? .white : .secondary) : .white)
                    .frame(width: 60, height: 28)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(buttonColor.opacity(isTaskValid || sessionManager.currentState != .inactive ? 1.0 : 0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(.quaternary, lineWidth: 0.5)
                            )
                    )
                    .scaleEffect(buttonScale)
                    .animation(.easeInOut(duration: 0.15), value: buttonScale)
                    .animation(.easeInOut(duration: 0.2), value: buttonColor)
                    .animation(.easeInOut(duration: 0.2), value: isTaskValid)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!isTaskValid && sessionManager.currentState == .inactive)
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.1)) {
                    isHovered = hovering
                    buttonScale = hovering ? 1.05 : 1.0
                }
            }
            
            // Additional pause button for quick access when active
            if sessionManager.currentState == .active {
                Button(action: handlePauseAction) {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.primary)
                        .frame(width: 26, height: 28)
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .fill(.thinMaterial)
                                .opacity(0.7)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(.quaternary, lineWidth: 0.5)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                .transition(.scale.combined(with: .opacity))
                .animation(.easeInOut(duration: 0.2), value: sessionManager.currentState)
            }
        }
    }
    
    // MARK: - Actions
    
    private func handleMainAction() {
        withAnimation(.easeInOut(duration: 0.3)) {
            switch sessionManager.currentState {
            case .inactive:
                if isTaskValid {
                    sessionManager.startSession(with: taskText)
                    buttonScale = 0.95
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        buttonScale = 1.0
                    }
                }
            case .active:
                sessionManager.endSession()
                buttonScale = 0.95
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonScale = 1.0
                }
            case .paused:
                sessionManager.resumeSession()
                buttonScale = 0.95
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonScale = 1.0
                }
            }
        }
    }
    
    private func handlePauseAction() {
        withAnimation(.easeInOut(duration: 0.2)) {
            sessionManager.pauseSession()
        }
    }
}

/// Preview for SessionControlView
struct SessionControlView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager1 = SessionManager()
        let sessionManager2 = SessionManager()
        let sessionManager3 = SessionManager()
        
        sessionManager2.currentState = .active
        sessionManager2.currentTask = "Working on app"
        sessionManager3.currentState = .paused
        sessionManager3.currentTask = "Paused task"
        
        return VStack(spacing: 20) {
            // Inactive state
            SessionControlView(
                sessionManager: sessionManager1,
                taskText: "Sample task description"
            )
            
            // Active state
            SessionControlView(
                sessionManager: sessionManager2,
                taskText: "Working on app"
            )
            
            // Paused state
            SessionControlView(
                sessionManager: sessionManager3,
                taskText: "Paused task"
            )
            
            // Inactive with empty task
            SessionControlView(
                sessionManager: SessionManager(),
                taskText: ""
            )
        }
        .padding()
        .background(.ultraThinMaterial)
    }
} 