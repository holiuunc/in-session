# Development Tasks: In-Session Swift MVP

*Last Updated: 2025-07-21*

This document tracks all development tasks for the In-Session native macOS application built with Swift and SwiftUI. Tasks are organized by implementation phases and linked to corresponding user stories.

---

## 📊 **Current Sprint Status**

**Active Phase:** Phase 1 - Swift Foundation & Setup  
**Sprint Goal:** Native SwiftUI app with MenuBarExtra + Basic UI  
**Target Completion:** Week 1

**Progress Summary:**
- [x] **4/8** Phase 1 tasks completed ✅
- [ ] **0/10** Phase 2 tasks completed  
- [ ] **0/6** Phase 3 tasks completed
- [x] **4/24** Total tasks completed (17% complete)

**🚀 FRAMEWORK MIGRATION:** Migrated to native Swift/SwiftUI for optimal performance and native macOS integration!

---

## 🔄 **MIGRATION STATUS: Final → Swift/SwiftUI**

**Decision Date:** 2024-12-19  
**Reason:** Swift/SwiftUI provides the best possible experience for native macOS menu bar applications with liquid glass aesthetics.

**What We Gained:**
- ✅ **Perfect native macOS integration** with MenuBarExtra
- ✅ **Optimal performance** with native Swift compilationgit st
- ✅ **Beautiful liquid glass UI** with SwiftUI materials
- ✅ **Reliable window management** without framework limitations
- ✅ **Small bundle size** (~5-10MB vs 100MB+ for Electron)
- ✅ **Native system APIs** for screenshots, keychain, permissions

**Development Approach:**
- 🎯 **Primary Development:** Cursor with Swift extensions + Sweetpad
- 🔧 **Building & Running:** Xcode when needed for compilation/debugging
- 🎨 **Live Preview:** InjectionIII for hot reloading (optional setup)
- 📱 **UI Design:** Pure SwiftUI matching native macOS design language

---

## 🚀 **Phase 1: Swift Foundation & Setup (Week 1)**
*Focus: Project setup + Basic MenuBarExtra + UI foundation*

### **Epic 1: Project Initialization & Development Environment**
*Priority: P0 - Must complete first*

- [x] **TASK-001:** Set up Swift project structure ✅
  - [x] Create new Xcode project with Swift/SwiftUI
  - [x] Configure universal binary (Intel + Apple Silicon)
  - [x] Set minimum deployment target to macOS 14.0+
  - [x] Organize folder structure (Views, Services, Models, etc.)
  - **Status:** COMPLETED - Clean Xcode project created and running
  - **Acceptance:** Clean project builds and runs successfully ✅

- [x] **TASK-002:** Configure Cursor development environment ✅
  - [x] Install Swift Language Support extension
  - [x] Install Sweetpad extension for Xcode integration
  - [x] Configure Swift formatting and linting (.swiftlint.yml)
  - [x] Set up build tasks and debugging
  - **Status:** COMPLETED - Full Swift development environment configured
  - **Acceptance:** Can develop Swift in Cursor with syntax highlighting and completion ✅

- [x] **TASK-003:** Implement basic MenuBarExtra ✅
  - [x] Create main App entry point with MenuBarExtra
  - [x] Add basic menu bar icon (SF Symbol "target")
  - [x] Set up window style and liquid glass pill interface
  - [x] Test menu bar integration and click behavior
  - **Status:** COMPLETED - MenuBarExtra with liquid glass pill interface implemented
  - **Acceptance:** App appears in menu bar and shows beautiful pill window on click ✅

- [x] **TASK-004:** Create liquid glass pill-shaped UI ✅
  - [x] Implement MenuBarContentView with perfect pill shape using Capsule()
  - [x] Add SwiftUI .ultraThinMaterial background with subtle stroke
  - [x] Configure responsive sizing (350-450px width)
  - [x] Test transparent/translucent appearance with native materials
  - **Status:** COMPLETED - Perfect match to mockup with liquid glass aesthetic
  - **Acceptance:** Window matches mockup aesthetic with liquid glass effect ✅

### **Epic 2: Basic Session Management UI**
*Implements: US-001, US-002, US-003*

- [ ] **TASK-005:** Implement task input interface (US-001)
  - [ ] Create TaskInputView with SwiftUI TextField
  - [ ] Add placeholder text "What are you working on?"
  - [ ] Implement character limit (200 chars) with validation
  - [ ] Style input field to match native macOS design
  - **Acceptance:** Beautiful, functional text input matching mockup

- [ ] **TASK-006:** Create session control buttons (US-002)
  - [ ] Implement SessionControlView with Start button
  - [ ] Add button state management (@State, @Binding)
  - [ ] Style buttons with native SwiftUI button styles
  - [ ] Add button animations and interactions
  - **Acceptance:** Buttons work correctly and match native macOS feel

- [ ] **TASK-007:** Implement session state management (US-003)
  - [ ] Create SessionManager as @ObservableObject
  - [ ] Define SessionState enum (inactive, active, paused)
  - [ ] Implement start/stop/pause session logic
  - [ ] Add session state persistence across app launches
  - **Acceptance:** Session state managed correctly with proper UI updates

- [ ] **TASK-008:** Polish main interface layout
  - [ ] Fine-tune spacing and alignment to match mockup
  - [ ] Implement proper responsive sizing
  - [ ] Add smooth animations for state transitions
  - [ ] Test interface on different screen sizes/resolutions
  - **Acceptance:** Interface is pixel-perfect and feels native

---

## 🔍 **Phase 2: Core Services & AI Integration (Week 2)**
*Focus: Screenshot capture + AI API + Background services*

### **Epic 3: Screenshot Capture System**
*Implements: US-004*

- [ ] **TASK-009:** Implement ScreenCaptureKit service
  - [ ] Create ScreenshotService with ScreenCaptureKit
  - [ ] Handle screen recording permission requests
  - [ ] Implement screenshot capture with error handling
  - [ ] Add multi-monitor detection (capture primary screen)
  - **Acceptance:** Can capture screenshots reliably with proper permissions

- [ ] **TASK-010:** Add image processing pipeline
  - [ ] Implement Core Graphics image compression (JPEG 70-80%)
  - [ ] Add image resizing (max 1920px width) for bandwidth efficiency
  - [ ] Optimize memory usage for image processing
  - [ ] Add image quality/size validation
  - **Acceptance:** Screenshots processed efficiently with optimal file sizes

### **Epic 4: AI Service Integration**
*Implements: US-004, US-005*

- [ ] **TASK-011:** Create Gemini API client
  - [ ] Implement AIService with URLSession and async/await
  - [ ] Add API key validation and configuration
  - [ ] Create proper request/response models with Codable
  - [ ] Implement error handling and network timeout logic
  - **Acceptance:** Can communicate with Gemini API reliably

- [ ] **TASK-012:** Implement distraction detection logic
  - [ ] Integrate screenshot capture with AI analysis
  - [ ] Add rate limiting (90s free tier, 15-30s paid tier)
  - [ ] Implement 3-consecutive-distraction rule
  - [ ] Add background task scheduling with Swift Concurrency
  - **Acceptance:** Distraction detection works accurately with minimal false positives

### **Epic 5: Secure Storage & Configuration**
*Implements: US-006, US-007*

- [ ] **TASK-013:** Implement Keychain integration
  - [ ] Create KeychainService with Security framework
  - [ ] Add secure API key storage and retrieval
  - [ ] Implement proper error handling for Keychain operations
  - [ ] Add API key validation workflow
  - **Acceptance:** API keys stored securely and retrieved reliably

- [ ] **TASK-014:** Create settings management
  - [ ] Implement SettingsManager for app configuration
  - [ ] Add UserDefaults integration for non-sensitive settings
  - [ ] Create first-time setup flow with SwiftUI
  - [ ] Add API key input interface with validation
  - **Acceptance:** Complete onboarding flow with secure credential storage

### **Epic 6: Custom Notification System**
*Implements: US-005*

- [ ] **TASK-015:** Build custom notification UI
  - [ ] Create NotificationView with SwiftUI
  - [ ] Implement custom window positioning and stacking
  - [ ] Add notification dismiss functionality
  - [ ] Style notifications to match app aesthetic
  - **Acceptance:** Custom notifications appear and behave correctly

- [ ] **TASK-016:** Integrate notifications with detection
  - [ ] Connect AI detection results to notification system
  - [ ] Implement notification scheduling and timing
  - [ ] Add notification history and management
  - [ ] Test notification reliability and user experience
  - **Acceptance:** Notifications trigger appropriately based on AI analysis

---

## 🎨 **Phase 3: Polish & Native Integration (Week 3)**
*Focus: System integration + Error handling + Final polish*

### **Epic 7: System Integration & Lifecycle**
*Implements: US-010, US-011, US-012*

- [ ] **TASK-017:** Implement system event handling
  - [ ] Add NSWorkspace notifications for sleep/wake detection
  - [ ] Implement automatic session ending on system sleep
  - [ ] Handle network connectivity changes gracefully
  - [ ] Add proper app state restoration
  - **Acceptance:** App responds correctly to all system events

- [ ] **TASK-018:** Enhanced error handling & recovery
  - [ ] Create comprehensive SwiftUI error alert system
  - [ ] Add specific error messages for common issues
  - [ ] Implement retry mechanisms with exponential backoff
  - [ ] Add deep links to System Settings for permissions
  - **Acceptance:** All error conditions handled gracefully with clear user guidance

### **Epic 8: Performance & Memory Optimization**

- [ ] **TASK-019:** Optimize background processing
  - [ ] Profile memory usage during screenshot capture
  - [ ] Optimize Swift Concurrency task scheduling
  - [ ] Add proper task cancellation and cleanup
  - [ ] Minimize CPU usage during idle periods
  - **Acceptance:** App uses minimal system resources

- [ ] **TASK-020:** Polish UI animations and interactions
  - [ ] Add smooth transitions between session states
  - [ ] Implement menu bar icon animations
  - [ ] Polish button hover states and feedback
  - [ ] Add subtle sound effects or haptic feedback
  - **Acceptance:** Interface feels polished and responsive

### **Epic 9: Distribution Preparation**

- [ ] **TASK-021:** Prepare app for distribution
  - [ ] Configure app bundle and Info.plist properly
  - [ ] Add proper app icons in all required sizes
  - [ ] Test universal binary on Intel and Apple Silicon
  - [ ] Create installer/DMG packaging workflow
  - **Acceptance:** App packages correctly for distribution

- [ ] **TASK-022:** Final testing and validation
  - [ ] End-to-end testing of complete user workflow
  - [ ] Test edge cases and error scenarios
  - [ ] Validate performance across different Mac configurations
  - [ ] Ensure proper cleanup and resource management
  - **Acceptance:** App is stable and ready for user testing

---

## 🔧 **Development Setup Tasks (Optional)**

### **Live Preview Setup (Enhanced Development Experience):**
- [ ] **OPTIONAL-001:** Configure InjectionIII hot reloading
  - [ ] Install InjectionIII desktop app
  - [ ] Add Inject package to project
  - [ ] Configure SwiftUI views with .enableInjection()
  - [ ] Test live code updates without rebuilding
  - **Benefit:** See UI changes instantly during development

---

## 📝 **Task Management Notes**

**Development Environment:**
- **Primary Editor:** Cursor with Swift extensions
- **Building:** Xcode for compilation and device testing
- **Live Preview:** InjectionIII for SwiftUI hot reloading (optional)
- **Version Control:** Git with proper .gitignore for Xcode

**Swift-Specific Considerations:**
- **Concurrency:** Use async/await throughout for clean, maintainable code
- **Memory Management:** Leverage Swift's ARC, avoid retain cycles
- **Error Handling:** Use Result types and proper Swift error handling
- **Architecture:** MVVM with @ObservableObject for clear separation of concerns

**Estimated Time per Task:**
- Foundation tasks (001-004): 1-2 hours each
- Core feature tasks (005-016): 2-4 hours each  
- Polish tasks (017-022): 1-2 hours each
- **Total Estimated Time:** ~40-60 hours for complete MVP

**Critical Path Dependencies:**
- MenuBarExtra foundation (TASK-003) → All UI tasks
- ScreenCaptureKit service (TASK-009) → AI integration
- API service (TASK-011) → Distraction detection
- All core services → Final integration and testing

---

*This document will be updated as development progresses with actual completion times and any discovered requirements.* 