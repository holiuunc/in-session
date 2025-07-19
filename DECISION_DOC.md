# Design & Technical Document: In-Session (v0.1)

This document outlines the initial design, user experience flow, and technical specifications for the In-Session macOS application.

### 1. Overview

In-Session is a macOS utility that helps users maintain focus during work sessions. The user defines their task with a text description. The application then periodically captures screenshots, uses a multimodal AI API to analyze if the screen content is relevant to the task, and notifies the user if they are distracted. The initial version (MVP) will prioritize a minimal, functional implementation of this core loop.

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
    1.  The application captures a screenshot of the user's primary screen only (no multi-monitor support in MVP).
    2.  Screenshot is compressed to JPEG format (70-80% quality) and resized to maximum 1920px width for optimal network usage.
    3.  The screenshot image and the user-provided task description are sent to the Gemini API.
    4.  The API returns a response indicating whether the user is "on-task" or "distracted".
*   **Logic:** The core logic is entirely managed by the AI's interpretation. The app itself only acts on the binary response from the API.

#### 2.3. User Notification System
*   **Type:** Custom on-screen notification (not standard macOS notification for more intrusive behavior).
*   **Trigger Logic:** Notifications only appear after **3 consecutive "distracted" flags** to prevent false positives and one-time deviations.
*   **Notification Content:** "You have been flagged, are you distracted?" with a dismiss button.
*   **Behavior:** Notifications stack on each other if multiple occur.
*   **Dismissal:** Simple "Dismiss" button for MVP. Advanced deterrence mechanisms will be considered for future versions.

### 3. User Experience (UX) Flow

#### 3.1. First-Time User Onboarding
1.  **Account Creation:** User provides email and password as login credentials.
2.  **Permission Requests:** 
    *   Request screen recording permission (required for screenshot capture)
    *   Request notification permission (for distraction alerts)
3.  **API Key Configuration:** User enters their own Gemini API key, stored securely in macOS Keychain Services.
4.  **No Fallback:** If permissions are denied, app cannot function - user must grant permissions to proceed.

#### 3.2. Main Application Flow
1.  **Application Interface:** Small pill-shaped menubar app with Apple Liquid Glass design aesthetic.
2.  **UI Elements:** 
    *   Text input field: "What are you working on?"
    *   Dynamic button: "Start Session" / "End Session" / "Pause Session"
3.  **Session States:**
    *   **Not Active:** Clear/empty light indicator, "Start Session" button
    *   **Active:** White light indicator (non-distracting), "End Session" and "Pause Session" buttons
    *   **Paused:** Dimmed indicator, "Resume Session" button
4.  **Session Management:** 
    *   Users can start, pause, resume, and end sessions via the main interface
    *   If app is force-quit during session, restart treats it as no active session

### 4. Technical Specifications

#### 4.1. Platform & System Requirements
*   **Operating System:** macOS Sequoia 15.0+ 
*   **Architecture:** Universal (Intel + Apple Silicon)
*   **Distribution:** Direct download for MVP, potential Mac App Store later
*   **Code Signing:** Not required for MVP
*   **Auto-Updates:** Not implemented in MVP

#### 4.2. AI & Backend Integration
*   **AI Service:** Google Gemini API (user-provided API keys)
*   **AI Model:** Gemini 2.5 Flash (optimal balance of performance and cost)
*   **API Key Management:** Stored securely in macOS Keychain Services, user-based persistence
*   **Rate Limiting Strategy:** 
    *   Free tier: 1.5-minute intervals (based on 250 RPD limit for 6-hour usage)
    *   Paid tier: 15-30 second intervals (based on 10,000 RPD limit)
*   **API Prompting Strategy:** 
    *   **Prompt:** `"The user's goal is: '[USER-PROVIDED GOAL]'. Based on the attached screenshot, is the user's activity on screen directly related to this goal? Answer only with the word 'True' or 'False'."`
*   **Data & Privacy:** Screenshots are ephemeral, sent for one-time analysis and discarded immediately. No user screen data stored locally or logged.

#### 4.3. Client Application Architecture
*   **Screenshot Capture:** Native macOS APIs (`CGWindowListCreateImage`) for primary screen only
*   **Image Processing:** JPEG compression (70-80% quality), resize to max 1920px width
*   **Performance Optimization:**
    *   Efficient screenshot APIs with minimal options
    *   Batch network requests when possible  
    *   Smart scheduling (pause during system idle)
    *   Low-power timer APIs for battery optimization
*   **Network Usage:** Compressed screenshots reduce bandwidth ~10x compared to raw images

#### 4.4. Error Handling & Resilience
*   **Gemini API Unavailable:** App remains dependent on Gemini service availability
*   **Network Connectivity:** Requires internet connection - no offline functionality
*   **Screenshot Capture Failure:** 
    *   Retry after next interval period
    *   After multiple consecutive failures, display error message directing user to check permissions
*   **API Quota Exhaustion:** Rate limiting prevents quota issues through interval management

#### 4.5. User Interface Design
*   **Design Language:** Apple Liquid Glass aesthetic - minimal, sleek, native macOS appearance
*   **Form Factor:** Small pill-shaped menubar application similar to ChatGPT's quick access interface
*   **Status Indicators:**
    *   **Not in session:** No indicator (empty/clear)
    *   **Active session:** White light (non-distracting)
    *   **Paused session:** Dimmed light
*   **Menu Bar Integration:** Primary interface lives in macOS menu bar

### 5. Security & Privacy Considerations
*   **Credential Storage:** API keys secured via macOS Keychain Services with user authentication
*   **Screen Data:** No local storage of screenshots, immediate disposal after API analysis
*   **User Authentication:** Email/password system for user identification and settings persistence
*   **Permissions:** Explicit user consent for screen recording and notifications

### 6. Future Considerations (Post-MVP)
*   **Advanced Deterrence:** More engaging notification dismissal mechanisms
*   **Multi-Monitor Support:** Capture and analyze multiple screens
*   **Mac App Store Distribution:** Code signing and sandboxing requirements
*   **Auto-Update System:** Automatic version management
*   **On-Device AI:** Core ML integration for enhanced privacy and reduced API dependency
*   **Advanced Analytics:** User pattern recognition and personalized distraction detection
*   **Notification Customization:** User-configurable severity levels and response types