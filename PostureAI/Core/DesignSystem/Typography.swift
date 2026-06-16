import SwiftUI

enum Typography {
    static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
    static let title = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let headline = Font.system(size: 22, weight: .semibold, design: .default)
    static let body = Font.system(size: 17, weight: .regular, design: .default)
    static let callout = Font.system(size: 16, weight: .regular, design: .default)
    static let subhead = Font.system(size: 15, weight: .regular, design: .default)
    static let caption1 = Font.system(size: 13, weight: .regular, design: .default)
    static let caption2 = Font.system(size: 12, weight: .regular, design: .default)
}

// MARK: - Text Styles

extension Text {
    func largeTitle() -> Text {
        font(.largeTitle)
            .bold()
            .foregroundColor(.textPrimary)
    }
    
    func title() -> Text {
        font(.title)
            .semibold()
            .foregroundColor(.textPrimary)
    }
    
    func headline() -> Text {
        font(.headline)
            .semibold()
            .foregroundColor(.textPrimary)
    }
    
    func body() -> Text {
        font(.body)
            .foregroundColor(.textPrimary)
    }
    
    func callout() -> Text {
        font(.callout)
            .foregroundColor(.textPrimary)
    }
    
    func subhead() -> Text {
        font(.subhead)
            .foregroundColor(.textPrimary)
    }
    
    func caption1() -> Text {
        font(.caption1)
            .foregroundColor(.textMuted)
    }
    
    func caption2() -> Text {
        font(.caption2)
            .foregroundColor(.textMuted)
    }
}
