# User Stories: In-Session MVP

This document outlines user-focused features and goals for the In-Session macOS application, organized by implementation priority.

---

## 🎯 **Core Value Proposition**
*As a knowledge worker, I want an AI-powered focus assistant that helps me stay on task without being intrusive, so that I can maintain deep work sessions and build better focus habits.*

---

## 📋 **Epic 1: Basic Focus Session Management**
*Priority: P0 (Must Have) - Core MVP functionality*

### **US-001: Define Focus Goal**
**As a user, I want to easily describe what I'm working on, so that the AI knows what "on-task" means for my current session.**

**Acceptance Criteria:**
- [ ] Simple text input field in the app interface
- [ ] Placeholder text: "What are you working on?"
- [ ] Input persists during active session
- [ ] Clear input when session ends
- [ ] Support for multi-line descriptions

### **US-002: Start Focus Session**
**As a user, I want to start a focus session with one click, so that I can quickly begin focused work without friction.**

**Acceptance Criteria:**
- [ ] "Start Session" button prominently displayed
- [ ] Button changes to show session is active
- [ ] Menu bar icon indicates active session
- [ ] Session begins screenshot monitoring immediately
- [ ] Task description is required before starting

### **US-003: End Focus Session** 
**As a user, I want to manually end my focus session, so that I have control over when monitoring stops.**

**Acceptance Criteria:**
- [ ] "End Session" button visible during active session
- [ ] Immediate stop of all screenshot monitoring
- [ ] Menu bar returns to inactive state
- [ ] Task description is cleared
- [ ] Session state resets completely

---

## 🔍 **Epic 2: AI-Powered Distraction Detection**
*Priority: P0 (Must Have) - Core value delivery*

### **US-004: Automatic Distraction Monitoring**
**As a user, I want the app to automatically check if I'm on-task at regular intervals, so that I don't have to self-monitor constantly.**

**Acceptance Criteria:**
- [ ] Screenshots taken every 90 seconds (free tier) or 15-30 seconds (paid tier)
- [ ] Screenshots sent to Gemini AI with task description
- [ ] AI returns binary on-task/distracted assessment
- [ ] Process happens silently in background
- [ ] No screenshots stored locally

### **US-005: Smart Distraction Alerts**
**As a user, I want to be notified only when I'm consistently distracted, so that I'm not interrupted by false positives.**

**Acceptance Criteria:**
- [ ] Notification only after 3 consecutive "distracted" flags
- [ ] Custom notification window (not standard macOS notification)
- [ ] Clear message: "You have been flagged, are you distracted?"
- [ ] Simple dismiss button
- [ ] Notifications can stack if multiple occur

---

## 🔐 **Epic 3: Setup & Configuration**
*Priority: P0 (Must Have) - Required for app function*

### **US-006: First-Time Setup**
**As a new user, I want a simple onboarding process, so that I can quickly start using the app.**

**Acceptance Criteria:**
- [ ] Request screen recording permission with clear explanation
- [ ] Request notification permission (with fallback if denied)
- [ ] API key input field with validation
- [ ] Clear instructions for obtaining Gemini API key
- [ ] Setup cannot be skipped - required for app function

### **US-007: API Key Management**
**As a user, I want to securely store my API key once, so that I don't have to enter it repeatedly.**

**Acceptance Criteria:**
- [ ] API key stored in macOS Keychain (encrypted)
- [ ] Validation occurs immediately when entered
- [ ] Clear error messages for invalid keys
- [ ] Option to update API key in settings
- [ ] Key never displayed in plain text after entry

---

## 🎨 **Epic 4: Native macOS Experience**
*Priority: P1 (Should Have) - User experience quality*

### **US-008: Menu Bar Integration**
**As a user, I want the app to live in my menu bar, so that it doesn't clutter my dock or desktop.**

**Acceptance Criteria:**
- [ ] App icon appears in macOS menu bar
- [ ] Click menu bar icon to show/hide main interface
- [ ] Visual indicator shows session status (active/inactive)
- [ ] Right-click context menu for quick actions
- [ ] No dock icon during normal operation

### **US-009: Beautiful Pill-Shaped Interface**
**As a user, I want a modern, Apple-like interface, so that the app feels native and premium.**

**Acceptance Criteria:**
- [ ] Transparent floating window with blur effects
- [ ] Pill-shaped design similar to ChatGPT interface
- [ ] Liquid glass aesthetic matching macOS design language
- [ ] Auto-hide when clicking outside window
- [ ] Smooth animations for show/hide
- [ ] Adapts to light/dark mode automatically

---

## ⚠️ **Epic 5: Error Handling & Recovery**
*Priority: P1 (Should Have) - Reliability and user trust*

### **US-010: Permission Problem Recovery**
**As a user, I want clear guidance when permissions are missing, so that I can fix issues and continue using the app.**

**Acceptance Criteria:**
- [ ] Persistent modal when screen recording permission denied
- [ ] Deep-link to System Preferences for easy permission granting
- [ ] Clear instructions with screenshots if needed
- [ ] Warning (not blocking) for missing notification permission
- [ ] Re-check permissions without app restart

### **US-011: Network & API Error Handling**
**As a user, I want to understand when something goes wrong, so that I can take appropriate action.**

**Acceptance Criteria:**
- [ ] Clear modal for network connectivity issues
- [ ] Specific error messages for API key problems
- [ ] Guidance on how to resolve common issues
- [ ] Option to retry failed operations
- [ ] Session gracefully pauses during extended outages

---

## 🔄 **Epic 6: System Integration**
*Priority: P2 (Could Have) - Polish and reliability*

### **US-012: Smart Session Management**
**As a user, I want the app to handle system events intelligently, so that sessions don't run inappropriately.**

**Acceptance Criteria:**
- [ ] Automatically end session when system goes to sleep
- [ ] End session when system is idle for extended period
- [ ] Require manual restart after system wake
- [ ] Handle network reconnection gracefully
- [ ] Clean recovery from app crashes (no ghost sessions)

---

## 📊 **Success Metrics for MVP**
*How we'll know the user stories are successful:*

**Engagement Metrics:**
- [ ] Users start at least 1 session per day
- [ ] Average session length > 15 minutes
- [ ] < 20% abandonment during onboarding

**Effectiveness Metrics:**
- [ ] < 5% false positive distraction alerts
- [ ] Users dismiss < 30% of distraction notifications
- [ ] No crashes during normal operation

**User Experience Metrics:**
- [ ] Setup completion in < 3 minutes
- [ ] No support requests for basic functionality
- [ ] Positive feedback on UI/UX design

---

## 🚀 **Implementation Phases**

### **Phase 1: Core Functionality (Weeks 1-3)**
- US-001, US-002, US-003: Basic session management
- US-004, US-005: AI distraction detection
- US-006, US-007: Setup and API key management

### **Phase 2: Native Experience (Weeks 4-5)**
- US-008: Menu bar integration
- US-009: Pill-shaped interface with animations
- US-010: Permission handling

### **Phase 3: Polish & Reliability (Week 6)**
- US-011: Error handling and recovery
- US-012: System integration
- Final testing and refinement

---

*This document will serve as the foundation for creating specific, actionable tasks in our upcoming task.md workflow.* 