import SwiftUI

/// An expandable text input view that grows naturally with TextField's internal sizing
struct TaskInputView: View {
    @Binding var text: String
    let isDisabled: Bool  
    let placeholder: String
    
    @FocusState private var isFocused: Bool
    
    // Constants for limits
    private let maxCharacterLimit = 200
    private let maxLines = 4
    
    var body: some View {
        VStack(spacing: 4) {
            // TextField with focus management that respects disabled state
            ZStack {
                TextField("", text: $text, axis: .vertical)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .textFieldStyle(.plain)
                    .disabled(isDisabled)
                    .focused($isFocused)
                    .lineLimit(1...maxLines)
                    .focusEffectDisabled()
                    .buttonStyle(.plain)
                    .background(Color.clear)
                    .cornerRadius(0)
                    .overlay(
                        Rectangle()
                            .stroke(Color.clear, lineWidth: 0)
                    )
                    .accentColor(.clear) // Remove accent color effects
                    .tint(.clear) // Remove tint effects
                    .onChange(of: isDisabled) { _, newValue in
                        // Clear focus when disabled to prevent focus conflicts
                        if newValue {
                            isFocused = false
                        }
                    }
            }
            .background(Color.clear)
            .clipped() // Clip any overflow styling
                .onChange(of: text) { oldValue, newValue in
                    // Skip processing if disabled to prevent update conflicts
                    guard !isDisabled else { return }
                    
                    // Enforce character limit only
                    if newValue.count > maxCharacterLimit {
                        text = String(newValue.prefix(maxCharacterLimit))
                    }
                }
                .overlay(
                    // Placeholder text
                    HStack {
                        if text.isEmpty && !isFocused {
                            Text(placeholder)
                                .foregroundColor(.secondary)
                                .font(.system(size: 14))
                                .allowsHitTesting(false)
                        }
                        Spacer()
                    },
                    alignment: .leading
                )
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
            
            // Character count indicator
            if !text.isEmpty || isFocused {
                HStack {
                    Spacer()
                    Text("\(text.count)/\(maxCharacterLimit)")
                        .font(.system(size: 10))
                        .foregroundColor(text.count >= maxCharacterLimit * 9 / 10 ? .orange : .secondary)
                        .animation(.easeInOut(duration: 0.15), value: text.count)
                }
                .padding(.horizontal, 8)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        TaskInputView(
            text: .constant(""),
            isDisabled: false,
            placeholder: "What are you working on?"
        )
        .frame(width: 280)
        
        TaskInputView(
            text: .constant("This is a longer text that should wrap to multiple lines"),
            isDisabled: false,
            placeholder: "What are you working on?"
        )
        .frame(width: 280)
        
        TaskInputView(
            text: .constant("Short text"),
            isDisabled: true,
            placeholder: "What are you working on?"
        )
        .frame(width: 280)
    }
    .padding()
    .background(.ultraThinMaterial)
} 