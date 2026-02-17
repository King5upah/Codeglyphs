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
            Text(code)
                .font(.system(.subheadline, design: .monospaced))
                .foregroundColor(theme.textColor)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = code
    }
}

public struct CodeglyphTheme {
    public let backgroundColor: Color
    public let headerColor: Color
    public let textColor: Color
    public let secondaryTextColor: Color
    public let borderColor: Color
    public let accentColor: Color
    public let glowColor: Color
    
    /// A dark, mysterious theme inspired by the stone blocks of the Void Century.
    public static let voidCentury = CodeglyphTheme(
        backgroundColor: Color(red: 0.08, green: 0.08, blue: 0.1),
        headerColor: Color(red: 0.12, green: 0.12, blue: 0.15),
        textColor: Color(red: 0.9, green: 0.9, blue: 0.95),
        secondaryTextColor: Color.blue.opacity(0.6),
        borderColor: Color.blue.opacity(0.2),
        accentColor: .blue,
        glowColor: .blue
    )
}
