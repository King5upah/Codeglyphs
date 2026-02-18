import SwiftUI
import Codeglyphs

@main
struct CodeglyphsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            DemoContentView()
        }
    }
}

struct DemoContentView: View {
    @State private var text: String = "let greeting = \"Hello, Pirate!\"\nprint(greeting)"
    @State private var selectedTheme: CodeglyphTheme = .voidCentury
    
    var body: some View {
        NavigationStack {
            List {
                Section("Live Editor") {
                    TextEditor(text: $text)
                        .font(.system(.body, design: .monospaced))
                        .frame(height: 100)
                }
                
                Section("Resulting Codéglyph") {
                    CodeglyphView(text, language: "swift", theme: selectedTheme)
                        .frame(minHeight: 250)
                        .padding(.vertical)
                }
                
                Section("Lore & Themes") {
                    Button(action: { selectedTheme = .voidCentury }) {
                        Label("Void Century (Default)", systemImage: "moon.stars.fill")
                    }
                    
                    Button(action: { selectedTheme = .raftelGold }) {
                        Label("Raftel Gold (Premium)", systemImage: "crown.fill")
                    }
                }
            }
            .navigationTitle("Codéglyphs Demo")
        }
    }
}

extension CodeglyphTheme {
    static let raftelGold = CodeglyphTheme(
        backgroundColor: Color(red: 0.15, green: 0.12, blue: 0.05),
        headerColor: Color(red: 0.2, green: 0.18, blue: 0.1),
        textColor: Color(red: 1.0, green: 0.84, blue: 0.0),
        secondaryTextColor: Color.yellow.opacity(0.6),
        borderColor: Color.yellow.opacity(0.3),
        accentColor: .yellow,
        glowColor: .yellow
    )
}
