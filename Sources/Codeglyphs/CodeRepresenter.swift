import SwiftUI

/// A highly-integrated SwiftUI view for representing code snippets.
/// Designed for AI agents and documentation tools to provide reliable
/// syntax-aware visuals within iOS apps.
public struct CodeView: View {
    private let code: String
    private let language: String
    private let theme: CodeTheme
    
    public init(
        _ code: String,
        language: String = "swift",
        theme: CodeTheme = .default
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
    }
    
    private var headerBar: some View {
        HStack {
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

public struct CodeTheme {
    public let backgroundColor: Color
    public let headerColor: Color
    public let textColor: Color
    public let secondaryTextColor: Color
    public let borderColor: Color
    
    public static let `default` = CodeTheme(
        backgroundColor: Color(red: 0.1, green: 0.1, blue: 0.12),
        headerColor: Color(red: 0.15, green: 0.15, blue: 0.18),
        textColor: .white,
        secondaryTextColor: .gray,
        borderColor: .white.opacity(0.1)
    )
}
