import SwiftUI

/// The main content view for the MenuBarExtra - implements the liquid glass pill interface
struct MenuBarContentView: View {
    @State private var taskDescription: String = ""
    @State private var isSessionActive: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main pill-shaped container
            HStack(spacing: 12) {
                // Start/Stop Button
                Button(action: {
                    if isSessionActive {
                        endSession()
                    } else {
                        startSession()
                    }
                }) {
                    Text(isSessionActive ? "End" : "Start")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                        .frame(width: 50, height: 28)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(!isSessionActive && taskDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                
                // Task Input Field
                TextField("What are you working on?", text: $taskDescription)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .disabled(isSessionActive)
                    .frame(minWidth: 250)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial, in: Capsule())
            .overlay(
                Capsule()
                    .stroke(.quaternary, lineWidth: 0.5)
            )
        }
        .padding(8)
        .frame(minWidth: 350, maxWidth: 450)
    }
    
    /// Starts a new focus session
    private func startSession() {
        guard !taskDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        isSessionActive = true
    }
    
    /// Ends the current focus session
    private func endSession() {
        isSessionActive = false
        taskDescription = ""
    }
}

#Preview {
    MenuBarContentView()
        .frame(width: 400, height: 60)
} 