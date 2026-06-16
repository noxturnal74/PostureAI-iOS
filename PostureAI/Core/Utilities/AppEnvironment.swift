import SwiftUI
import Combine

// MARK: - NavigationRouter

enum Tab {
    case home
    case workouts
    case analytics
    case profile
}

class NavigationRouter: ObservableObject {
    @Published var currentTab: Tab = .home
    
    func switchTo(tab: Tab) {
        currentTab = tab
    }
}

// MARK: - AppEnvironment

struct AppEnvironment {
    static let shared = AppEnvironment()
    
    let apiBaseURL: URL
    let databaseURL: URL
    let analyticsEnabled: Bool
    
    init() {
        let isProduction = ProcessInfo.processInfo.environment[\"ENVIRONMENT\"] == \"production\"
        
        self.apiBaseURL = URL(string: isProduction ? \"https://api.postureai.com\" : \"https://dev-api.postureai.com\")!
        self.databaseURL = URL(string: \"https://db.postureai.com\")!
        self.analyticsEnabled = true
    }
}
