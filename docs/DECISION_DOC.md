# Design & Technical Document: In-Session (v0.2 - Swift)

This document outlines the design, user experience flow, and technical specifications for the In-Session macOS application built with Swift and SwiftUI.

### 1. Overview

In-Session is a native macOS menu bar utility that helps users maintain focus during work sessions. The user defines their task with a text description. The application then periodically captures screenshots, uses a multimodal AI API to analyze if the screen content is relevant to the task, and notifies the user if they are distracted. The initial version (MVP) will prioritize a minimal, functional implementation of this core loop with a beautiful native macOS interface.

### 2. Core Functionality

#### 2.1. Defining "On-Task"
*   **Method:** The user will define their current task via a single, simple text input field.
*   **Rationale:** For the MVP, this is the most straightforward implementation. It does not require complex UI for selecting specific applications or websites. The burden of interpretation is placed on the AI.

#### 2.2. Distraction Detection Mechanism
*   **Trigger:** The detection process is initiated at a fixed time interval based on API rate limits.
*   **Screenshot Interval:** 
    *   **Free Tier Users:** 1.5 minutes (90 seconds) - based on Gemini 2.5 Flash free tier limit of 250 RPD for 6-hour usage
    *   **Paid Tier Users:** 15-30 seconds - based on paid tier limits of 10,000 RPD
*   **Process:**
    1.  The application captures a screenshot using ScreenCaptureKit (macOS native API).
    2.  Screenshot is processed with Core Graphics (JPEG compression 70-80% quality, max 1920px width).
    3.  The screenshot image and the user-provided task description are sent to the Gemini API via URLSession.
    4.  The API returns a response indicating whether the user is "on-task" or "distracted".
*   **Logic:** The core logic is entirely managed by the AI's interpretation. The app itself only acts on the binary response from the API.

#### 2.3. User Notification System
*   **Type:** Custom SwiftUI notification window (not standard macOS notification for more intrusive behavior).
*   **Trigger Logic:** Notifications only appear after **3 consecutive "distracted" flags** to prevent false positives and one-time deviations.
*   **Notification Content:** "You have been flagged, are you distracted?" with a dismiss button.
*   **Behavior:** Notifications stack on each other if multiple occur.
*   **Dismissal:** Simple "Dismiss" button for MVP. Advanced deterrence mechanisms will be considered for future versions.

### 3. User Experience (UX) Flow

#### 3.1. First-Time User Onboarding
1.  **Permission Requests:** 
    *   Request screen recording permission (required for ScreenCaptureKit)
    *   Request notification permission (for distraction alerts)
2.  **API Key Configuration:** User enters their own Gemini API key, stored securely in macOS Keychain via Security framework.
3.  **No Fallback:** If permissions are denied, app cannot function - user must grant permissions to proceed.

#### 3.2. Main Application Flow
1.  **Application Interface:** Small pill-shaped menu bar window with native macOS liquid glass design aesthetic.
2.  **UI Elements:** 
    *   Text input field: "What are you working on?"
    *   Dynamic button: "Start Session" / "End Session" / "Pause Session"
3.  **Session States:**
    *   **Not Active:** Subtle menu bar icon, "Start Session" button
    *   **Active:** Animated/glowing menu bar icon, "End Session" and "Pause Session" buttons
    *   **Paused:** Dimmed menu bar icon, "Resume Session" button
4.  **Session Management:** 
    *   Users can start, pause, resume, and end sessions via the main interface
    *   If app is force-quit during session, restart treats it as no active session

### 4. Technical Specifications

#### 4.1. Platform & System Requirements
*   **Operating System:** macOS 14.0+ (Sonoma or later for latest SwiftUI features)
*   **Architecture:** Universal (Intel + Apple Silicon) via Xcode's universal binary support
*   **Tech Stack:** Swift + SwiftUI + Swift Concurrency (async/await)
*   **Development Environment:** Cursor IDE with Sweetpad extension + periodic Xcode builds
*   **Distribution Strategy:** 
    *   Direct .dmg download from website/GitHub releases
    *   No Mac App Store for MVP (avoids sandboxing complexity)
    *   Manual version updates - user re-downloads new versions
*   **Code Signing:** Not required for MVP (users will see security warning)
*   **Build Process:** Xcode creates universal binary automatically

**Framework Decision Update (2024-12-19):**
*MIGRATED to native Swift/SwiftUI for optimal performance, native macOS integration, and liquid glass aesthetic. SwiftUI's MenuBarExtra provides perfect support for pill-shaped, translucent menu bar applications with reliable window management.*

#### 4.2. AI & Backend Integration
*   **AI Service:** Google Gemini API (user-provided API keys)
*   **AI Model:** Gemini 2.5 Flash (optimal balance of performance and cost)
*   **API Key Management:** Stored securely in macOS Keychain via Security framework
*   **HTTP Client:** Native URLSession with async/await for clean concurrency
*   **Rate Limiting Strategy:** 
    *   Free tier: 1.5-minute intervals (based on 250 RPD limit for 6-hour usage)
    *   Paid tier: 15-30 second intervals (based on 10,000 RPD limit)
*   **API Prompting Strategy:** 
    *   **Prompt:** `"The user's goal is: '[USER-PROVIDED GOAL]'. Based on the attached screenshot, is the user's activity on screen directly related to this goal? Answer only with the word 'True' or 'False'."`
*   **Data & Privacy:** Screenshots are ephemeral, sent for one-time analysis and discarded immediately. No user screen data stored locally or logged.

#### 4.3. Native Swift Application Architecture

**Frontend (SwiftUI):**
*   **UI Framework:** Pure SwiftUI with native macOS design language
*   **Window Management:** MenuBarExtra for pill-shaped, liquid glass interface
*   **Styling:** Native SwiftUI materials (.ultraThinMaterial, .regularMaterial)
*   **State Management:** @StateObject, @ObservableObject with Combine
*   **Architecture Pattern:** MVVM (Model-View-ViewModel)
*   **Component Structure:**
    *   MenuBarExtra for system integration
    *   SessionView for main pill interface
    *   NotificationWindow for custom alerts

**Backend (Swift Services):**
*   **Screenshot Capture:** ScreenCaptureKit (macOS native, high-performance)
*   **Image Processing:** Core Graphics for JPEG compression and resizing
*   **Keychain Integration:** Security framework for secure API key storage
*   **System Permissions:** Native permission request APIs
*   **HTTP Client:** URLSession with Swift Concurrency (async/await)
*   **Timer Management:** Swift async Task scheduling with cancellation

**Performance & Native Integration:**
*   **Bundle Size:** ~5-10MB (native Swift binary)
*   **Memory Usage:** ~20-30MB (native Swift efficiency)
*   **CPU Usage:** Minimal background processing
*   **Battery Impact:** Optimized with proper async/await patterns
*   **System Integration:** Full native macOS APIs and behaviors

#### 4.4. Swift Project Structure
```
InSession/
├── InSession.xcodeproj
├── InSession/
│   ├── App/
│   │   ├── InSessionApp.swift           // Main app entry point
│   │   └── ContentView.swift            // Root SwiftUI view
│   ├── Views/
│   │   ├── MenuBarView.swift            // Main pill interface
│   │   ├── SessionControlView.swift     // Start/Stop controls
│   │   ├── TaskInputView.swift          // Text input field
│   │   └── NotificationView.swift       // Custom notification
│   ├── ViewModels/
│   │   ├── SessionManager.swift         // Session state management
│   │   └── SettingsManager.swift        // App configuration
│   ├── Services/
│   │   ├── ScreenshotService.swift      // ScreenCaptureKit wrapper
│   │   ├── AIService.swift              // Gemini API client
│   │   ├── KeychainService.swift        // Secure storage
│   │   └── PermissionService.swift      // System permissions
│   ├── Models/
│   │   ├── SessionState.swift           // Session data models
│   │   └── AIResponse.swift             // API response models
│   ├── Utilities/
│   │   ├── Extensions.swift             // Swift extensions
│   │   └── Constants.swift              // App constants
│   └── Resources/
│       ├── Assets.xcassets              // Icons, images
│       └── Info.plist                   // App metadata
└── README.md
```

#### 4.5. Live Preview Development Setup (Optional)
For enhanced Cursor development experience:
*   **Inject Framework:** Hot reloading for SwiftUI views during development
*   **InjectionIII:** Desktop app for live code injection
*   **Setup:** Add `.enableInjection()` to SwiftUI views for real-time updates
*   **Benefit:** See UI changes instantly without rebuilding in Xcode

#### 4.6. Key Swift Dependencies (Minimal)
*   **No External Dependencies:** Leveraging native Swift/SwiftUI frameworks only
*   **ScreenCaptureKit:** Built-in macOS framework for screenshot capture
*   **Security:** Built-in framework for Keychain access
*   **Foundation:** URLSession for HTTP, FileManager for local storage
*   **SwiftUI:** Native UI framework with MenuBarExtra support
*   **Combine:** Reactive programming for state management

#### 4.7. Error Handling & Resilience

**Permission Management:**
*   **Screen Recording Permission:** Required for ScreenCaptureKit functionality
    *   If denied: Show persistent SwiftUI modal with instructions until granted
    *   No fallback mode - app cannot function without screenshot access
    *   Modal includes direct link to System Settings Privacy & Security
*   **Notification Permission:** Recommended but not blocking
    *   If denied: App continues but warns user about reduced effectiveness

**API Key Validation & Errors:**
*   **Validation Timing:** Validate API key immediately upon user input using async/await
*   **Invalid Key Response:** Display SwiftUI alert with clear error message and re-input option
*   **Runtime API Failures:** Same alert system for mid-session API issues
*   **Network Connectivity:** SwiftUI alert prompting user to check internet connection
*   **API Quota Exhaustion:** Rate limiting prevents quota issues through proper interval management

**System Lifecycle Management:**
*   **System Sleep/Wake Detection:** NSWorkspace notifications for system events
*   **Automatic Session Management:** End active session on system sleep (intentional design)
*   **Network Reconnection:** Automatic retry with exponential backoff
*   **App State Restoration:** Proper state management across app launches

#### 4.8. User Interface Design
*   **Design Language:** Native macOS liquid glass aesthetic with SwiftUI materials
*   **Implementation:** Pure SwiftUI components with .ultraThinMaterial background
*   **Form Factor:** MenuBarExtra pill-shaped window matching your mockup design
*   **Window Properties:**
    *   Native SwiftUI materials for translucent blur effects
    *   Rounded rectangle shape with proper corner radius
    *   Automatic light/dark mode adaptation
    *   Native window shadows and behaviors
*   **Status Indicators:**
    *   **Not in session:** Subtle menu bar SF Symbol
    *   **Active session:** Animated SF Symbol with color indication
    *   **Paused session:** Dimmed menu bar icon
*   **Menu Bar Integration:** MenuBarExtra with native system behavior
*   **Responsive Design:** Automatic adaptation to macOS appearance settings

### 5. Security & Privacy Considerations
*   **Credential Storage:** API keys secured via macOS Keychain with app-specific access
*   **Screen Data:** No local storage of screenshots, immediate disposal after API analysis
*   **System Permissions:** Explicit user consent for ScreenCaptureKit and notifications
*   **Network Security:** HTTPS-only communication with Gemini API via URLSession

### 6. Future Considerations (Post-MVP)
*   **Advanced Deterrence:** More engaging notification dismissal mechanisms
*   **Multi-Monitor Support:** Capture and analyze multiple screens with ScreenCaptureKit
*   **Mac App Store Distribution:** Code signing and sandboxing requirements
*   **Auto-Update System:** Sparkle framework integration for automatic updates
*   **On-Device AI:** Core ML integration for enhanced privacy and reduced API dependency
*   **Advanced Analytics:** User pattern recognition with SwiftUI Charts
*   **Menu Bar Customization:** User-configurable menu bar appearance and behaviors