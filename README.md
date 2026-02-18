# Codéglyphs 🏴‍☠️📜

**Codéglyphs** is a Poneglyph-inspired code representation engine for iOS and macOS. Designed specifically for AI agents, technical documentation, and learning tools, it brings clarity and "historical significance" to your code snippets.

## Features
- **Void Century Theme:** A high-contrast, glowing dark theme designed for maximum readability.
- **AI-Ready:** Simplified initialization for programmatic generation by AI agents.
- **Native SwiftUI:** Built 100% in SwiftUI for seamless integration and performance.
- **One-Tap Copy:** Built-in clipboard management.

## Installation

### Swift Package Manager
Add Codéglyphs to your project using SPM:

```swift
dependencies: [
    .package(url: "https://github.com/King5upah/Codeglyphs", from: "1.0.0")
]
```

## Quick Start

```swift
import Codeglyphs

struct MyView: View {
    let code = "print('Hello, Grand Line!')"
    
    var body: some View {
        CodeglyphView(code, language: "swift")
            .frame(height: 200)
    }
}
```

## The Lore
In the world of code, information is often lost in translation. **Codéglyphs** ensures that your logic remains as durable and striking as the ancient stones of the Void Century.
