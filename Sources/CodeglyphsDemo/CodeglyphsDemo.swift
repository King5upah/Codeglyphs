import SwiftUI
import Codeglyphs

@main
struct CodeglyphsDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DemoContentView()
                .tabItem {
                    Label("Editor", systemImage: "pencil.and.outline")
                }
            
            DocumentationView()
                .tabItem {
                    Label("Guide", systemImage: "book.fill")
                }
        }
        .tint(.blue)
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

struct DocumentationView: View {
    let installationCode = """
    // Add to your Package.swift
    dependencies: [
        .package(url: "https://github.com/King5upah/Codeglyphs", from: "1.0.0")
    ]
    """
    
    let usageCode = """
    import SwiftUI
    import Codeglyphs

    struct ContentView: View {
        var body: some View {
            CodeglyphView("print('Hello World')", language: "swift")
        }
    }
    """
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("How to use Codéglyphs")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Bring the power of the Void Century to your own iOS project.")
                        .foregroundColor(.secondary)
                    
                    SectionHeader(title: "1. Installation")
                    Text("Add the package via Swift Package Manager using the repository URL:")
                    CodeglyphView("https://github.com/King5upah/Codeglyphs", language: "url")
                    
                    SectionHeader(title: "2. Swift Package Manifest")
                    Text("Or add it directly to your Package.swift dependencies:")
                    CodeglyphView(installationCode, language: "swift")
                    
                    SectionHeader(title: "3. Basic Usage")
                    Text("Import the library and use the CodeglyphView component:")
                    CodeglyphView(usageCode, language: "swift")
                    
                    SectionHeader(title: "4. Customizing Themes")
                    Text("You can pass a custom CodeglyphTheme to match your app's aesthetic. The default is .voidCentury.")
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
            .navigationTitle("Guide")
        }
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .padding(.top)
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
