import Foundation
import SwiftUI

/// Represents the different states of a focus session
enum SessionState {
    case inactive
    case active
    case paused
    
    var displayName: String {
        switch self {
        case .inactive: return "Start"
        case .active: return "End"
        case .paused: return "Resume"
        }
    }
    
    var isActive: Bool {
        switch self {
        case .active: return true
        case .inactive, .paused: return false
        }
    }
}

/// Manages the current focus session state and persistence
@Observable
class SessionManager {
    var currentState: SessionState = .inactive
    var currentTask: String = ""
    var sessionStartTime: Date?
    var sessionDuration: TimeInterval = 0
    
    // MARK: - Private Properties
    private let userDefaults = UserDefaults.standard
    private let taskKey = "current_task"
    private let sessionStateKey = "session_state"
    private let sessionStartTimeKey = "session_start_time"
    
    init() {
        loadSessionState()
    }
    
    // MARK: - Public Methods
    
    /// Starts a new focus session with the given task
    func startSession(with task: String) {
        guard !task.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        currentTask = task
        currentState = .active
        sessionStartTime = Date()
        sessionDuration = 0
        
        saveSessionState()
    }
    
    /// Ends the current session and resets state
    func endSession() {
        currentState = .inactive
        currentTask = ""
        sessionStartTime = nil
        sessionDuration = 0
        
        clearSessionState()
    }
    
    /// Pauses the current session
    func pauseSession() {
        guard currentState == .active else { return }
        
        if let startTime = sessionStartTime {
            sessionDuration += Date().timeIntervalSince(startTime)
        }
        
        currentState = .paused
        sessionStartTime = nil
        
        saveSessionState()
    }
    
    /// Resumes a paused session
    func resumeSession() {
        guard currentState == .paused else { return }
        
        currentState = .active
        sessionStartTime = Date()
        
        saveSessionState()
    }
    
    /// Gets the total session duration including current active time
    func getTotalSessionDuration() -> TimeInterval {
        var total = sessionDuration
        
        if currentState == .active, let startTime = sessionStartTime {
            total += Date().timeIntervalSince(startTime)
        }
        
        return total
    }
    
    // MARK: - Persistence
    
    private func saveSessionState() {
        userDefaults.set(currentTask, forKey: taskKey)
        userDefaults.set(currentState.rawValue, forKey: sessionStateKey)
        
        if let startTime = sessionStartTime {
            userDefaults.set(startTime, forKey: sessionStartTimeKey)
        } else {
            userDefaults.removeObject(forKey: sessionStartTimeKey)
        }
    }
    
    private func loadSessionState() {
        currentTask = userDefaults.string(forKey: taskKey) ?? ""
        
        if let stateRawValue = userDefaults.object(forKey: sessionStateKey) as? String,
           let state = SessionState(rawValue: stateRawValue) {
            currentState = state
        }
        
        if let startTime = userDefaults.object(forKey: sessionStartTimeKey) as? Date {
            sessionStartTime = startTime
        }
    }
    
    private func clearSessionState() {
        userDefaults.removeObject(forKey: taskKey)
        userDefaults.removeObject(forKey: sessionStateKey)
        userDefaults.removeObject(forKey: sessionStartTimeKey)
    }
}

// MARK: - SessionState RawRepresentable Extension

extension SessionState: RawRepresentable {
    var rawValue: String {
        switch self {
        case .inactive: return "inactive"
        case .active: return "active"
        case .paused: return "paused"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "inactive": self = .inactive
        case "active": self = .active
        case "paused": self = .paused
        default: return nil
        }
    }
} 