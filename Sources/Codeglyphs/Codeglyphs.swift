import SwiftUI

/// Codeglyphs: A Poneglyph-inspired code representation engine for iOS.
/// Bringing clarity and historical significance to your snippets.
public struct CodeglyphView: View {
    private let code: String
    private let language: String
    private let theme: CodeglyphTheme
    
    public init(
        _ code: String,
        language: String = "swift",
        theme: CodeglyphTheme = .voidCentury
    ) {
        self.code = code
        self.language = language
        self.theme = theme
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerBar
            codeContent
        }
        .background(theme.backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.borderColor, lineWidth: 1)
        )
        .shadow(color: theme.glowColor.opacity(0.3), radius: 8)
    }
    
    private var headerBar: some View {
        HStack {
            Image(systemName: "archivebox.fill") // Poneglyph vibes
                .font(.caption)
                .foregroundColor(theme.accentColor)
            
            Text(language.uppercased())
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(theme.secondaryTextColor)
            
            Spacer()
            
            Button(action: copyToClipboard) {
                Image(systemName: "doc.on.doc")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(theme.headerColor)
    }
    
    private var codeContent: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            Text(highlightedCode)
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(theme.textColor)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var highlightedCode: AttributedString {
        SyntaxHighlighter.highlight(code, language: language, theme: theme)
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = code
    }
}

// MARK: - Syntax Highlighter
struct SyntaxHighlighter {
    static func highlight(_ code: String, language: String, theme: CodeglyphTheme) -> AttributedString {
        var attributedString = AttributedString(code)
        
        // Default color
        attributedString.foregroundColor = theme.textColor
        
        let range = NSRange(location: 0, length: code.utf16.count)
        
        // Define rules based on language
        let rules: [HighlightRule] = language.lowercased() == "dart" ? dartRules() : swiftRules()
        
        for rule in rules {
            let regex = try? NSRegularExpression(pattern: rule.pattern, options: [])
            regex?.enumerateMatches(in: code, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range, let range = Range(matchRange, in: attributedString) {
                    attributedString[range].foregroundColor = rule.color(for: theme)
                }
            }
        }
        
        return attributedString
    }
    
    struct HighlightRule {
        let pattern: String
        let color: (CodeglyphTheme) -> Color
    }
    
    static func swiftRules() -> [HighlightRule] {
        [
            // Keywords
            HighlightRule(pattern: "\\b(class|struct|enum|extension|protocol|func|var|let|if|else|guard|return|import|public|private|init|try|await|async|throws|catch|do)\\b") { $0.accentColor },
            // Types (Capitalized words, simplistic)
            HighlightRule(pattern: "\\b[A-Z][a-zA-Z0-9_]*\\b") { $0.typeColor },
            // Strings
            HighlightRule(pattern: "\".*?\"") { $0.stringColor },
            // Comments
            HighlightRule(pattern: "//.*") { $0.commentColor },
            // Numbers
            HighlightRule(pattern: "\\b\\d+\\b") { $0.numberColor }
        ]
    }
    
    static func dartRules() -> [HighlightRule] {
        [
            // Keywords
            HighlightRule(pattern: "\\b(class|abstract|extends|implements|with|mixin|void|int|double|String|bool|List|Map|return|if|else|var|final|const|dynamic|late|import|package|as|show|hide|async|await|Future|Stream|yield)\\b") { $0.accentColor },
            // Types (Capitalized words)
            HighlightRule(pattern: "\\b[A-Z][a-zA-Z0-9_]*\\b") { $0.typeColor },
            // Annotations
            HighlightRule(pattern: "@[a-zA-Z]+\\b") { $0.typeColor },
            // Strings
            HighlightRule(pattern: "[\"'].*?[\"']") { $0.stringColor },
            // Comments
            HighlightRule(pattern: "//.*") { $0.commentColor },
            // Numbers
            HighlightRule(pattern: "\\b\\d+\\b") { $0.numberColor }
        ]
    }
}

public struct CodeglyphTheme: Sendable {
    public let backgroundColor: Color
    public let headerColor: Color
    public let textColor: Color
    public let secondaryTextColor: Color
    public let borderColor: Color
    public let accentColor: Color // Keywords
    public let glowColor: Color
    
    // New Syntax Colors
    public let stringColor: Color
    public let commentColor: Color
    public let typeColor: Color
    public let numberColor: Color
    
    public init(
        backgroundColor: Color,
        headerColor: Color,
        textColor: Color,
        secondaryTextColor: Color,
        borderColor: Color,
        accentColor: Color,
        glowColor: Color,
        stringColor: Color = .green,
        commentColor: Color = .gray,
        typeColor: Color = .purple,
        numberColor: Color = .orange
    ) {
        self.backgroundColor = backgroundColor
        self.headerColor = headerColor
        self.textColor = textColor
        self.secondaryTextColor = secondaryTextColor
        self.borderColor = borderColor
        self.accentColor = accentColor
        self.glowColor = glowColor
        self.stringColor = stringColor
        self.commentColor = commentColor
        self.typeColor = typeColor
        self.numberColor = numberColor
    }
    
    /// A dark, mysterious theme inspired by the stone blocks of the Void Century.
    public static let voidCentury = CodeglyphTheme(
        backgroundColor: Color(red: 0.08, green: 0.08, blue: 0.1),
        headerColor: Color(red: 0.12, green: 0.12, blue: 0.15),
        textColor: Color(red: 0.9, green: 0.9, blue: 0.95),
        secondaryTextColor: Color.blue.opacity(0.6),
        borderColor: Color.blue.opacity(0.2),
        accentColor: Color(red: 0.4, green: 0.6, blue: 1.0), // Keywords (Soft Blue)
        glowColor: .blue,
        stringColor: Color(red: 0.6, green: 0.8, blue: 0.6), // Strings (Pale Green)
        commentColor: Color.gray.opacity(0.8),               // Comments
        typeColor: Color(red: 0.8, green: 0.6, blue: 1.0),   // Types (Soft Purple)
        numberColor: Color(red: 1.0, green: 0.8, blue: 0.6)  // Numbers (Soft Orange)
    )
}
