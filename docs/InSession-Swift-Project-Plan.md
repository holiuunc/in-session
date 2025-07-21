# In-Session Swift Project Plan

## 🎯 **Project Overview**

Native macOS menu bar application built with Swift/SwiftUI that helps users maintain focus through AI-powered distraction detection.

**Target UI:** Beautiful pill-shaped MenuBarExtra with liquid glass aesthetic matching your provided mockup.

---

## 📁 **Planned Project Structure**

```
InSession/
├── InSession.xcodeproj              # Xcode project file
├── InSession/
│   ├── App/
│   │   ├── InSessionApp.swift       # @main App entry point
│   │   └── ContentView.swift        # Root SwiftUI view
│   ├── Views/
│   │   ├── MenuBarView.swift        # Main pill interface
│   │   ├── SessionControlView.swift # Start/Stop buttons
│   │   ├── TaskInputView.swift      # "What are you working on?" field
│   │   └── NotificationView.swift   # Custom distraction alerts
│   ├── ViewModels/
│   │   ├── SessionManager.swift     # @ObservableObject for session state
│   │   └── SettingsManager.swift    # App configuration
│   ├── Services/
│   │   ├── ScreenshotService.swift  # ScreenCaptureKit wrapper
│   │   ├── AIService.swift          # Gemini API client
│   │   ├── KeychainService.swift    # Secure API key storage
│   │   └── PermissionService.swift  # System permissions
│   ├── Models/
│   │   ├── SessionState.swift       # Session data models
│   │   └── AIResponse.swift         # API response models
│   ├── Utilities/
│   │   ├── Extensions.swift         # Swift extensions
│   │   └── Constants.swift          # App constants
│   └── Resources/
│       ├── Assets.xcassets          # App icons, SF Symbols
│       └── Info.plist               # App metadata
├── README.md
└── .gitignore                       # Xcode gitignore
```

---

## 🛠 **Development Approach**

### **Primary Development Environment:**
- **Cursor IDE** for all Swift code editing with extensions:
  - Swift Language Support
  - Sweetpad (Xcode integration)
  - Optional: InjectionIII for live SwiftUI previews

### **Building & Testing:**
- **Xcode** for compilation, debugging, and device testing
- **Universal Binary** support for Intel + Apple Silicon

### **Live Preview (Optional Setup):**
- **InjectionIII**: Hot reloading for SwiftUI during development
- See UI changes instantly without rebuilding

---

## 🎨 **Technical Stack**

### **UI Framework:**
- **SwiftUI** with MenuBarExtra for native menu bar integration
- **Materials:** .ultraThinMaterial for liquid glass effect
- **Animations:** Native SwiftUI transitions

### **Core Services:**
- **ScreenCaptureKit:** Native screenshot capture
- **URLSession:** Async/await API communication
- **Security Framework:** Keychain integration
- **Core Graphics:** Image processing

### **Architecture:**
- **MVVM Pattern** with @ObservableObject
- **Swift Concurrency** for background tasks
- **Combine** for reactive state management

---

## ⚡ **Key Advantages**

### **Performance:**
- Bundle Size: ~5-10MB (vs 100MB+ Electron)
- Memory Usage: ~20-30MB (vs 100MB+ Electron)
- Native compilation for optimal performance

### **Native Integration:**
- Perfect MenuBarExtra support for pill-shaped windows
- Native macOS liquid glass materials
- Reliable window management
- System-level APIs for all functionality

### **Development Experience:**
- Excellent Cursor support with proper Swift extensions
- Live preview capabilities with InjectionIII
- Clean async/await patterns throughout

---

## 🚀 **Next Steps**

### **Week 1 Goals:**
1. **Initialize Xcode project** with universal binary support
2. **Configure Cursor environment** with Swift extensions
3. **Create MenuBarExtra** with basic window
4. **Implement liquid glass UI** matching your mockup aesthetic
5. **Build foundation** for session controls and task input

### **Ready to Begin:**
- All documentation restructured for Swift development
- Technical architecture defined
- Development environment plan established
- Task breakdown complete (24 total tasks)

---

## 📊 **Estimated Timeline**

**Week 1:** Swift Foundation & MenuBarExtra UI (8 tasks)
**Week 2:** Core Services & AI Integration (8 tasks)  
**Week 3:** Polish & Distribution Prep (8 tasks)

**Total Estimated Time:** 40-60 hours for complete MVP

---

*Ready to create the Xcode project and begin development!* 