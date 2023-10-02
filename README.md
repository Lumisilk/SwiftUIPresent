[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

# SwiftUIPresent

Present any view from SwiftUI with customizable styles.

## Features

- Add the missing fade-in fade-out (crossDissolve) and popover presentation style to SwiftUI.
- (WIP) Bringing the SwiftUI sheet's height adjustment (detents) API, exclusive to iOS 16, to iOS 15.
- Using your own custom presentation style in SwiftUI.

## Requirements

- iOS 14.0+
- Xcode 14.3.1

## Installation

### Swift Package Manager

Follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the SwiftUIPresent repo with the current version.

`https://github.com/Lumisilk/SwiftUIPresent.git`

## Usage

Currently, SwiftUIPresent has only one API `present(isPresented: Binding<Bool, style: some PresentationStyle)`

`isPresented` to determine whether to present or not, and `style` to determine the presentation style.

```swift
struct Example: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Present") {
            isPresented = true
        }
        .present(
            isPresented: $isPresented,
            style: .fade
        ) {
            Text("Your present content")
        }
    }
}
```

### Built-in Styles

| PresentationStyle                                            | The corresponding UIKit styles       |
| ------------------------------------------------------------ | ------------------------------------ |
| `.sheet`                                                     | `.formSheet`                         |
| `.fade(backgroundColor: UIColor = .clear)`                   | `.overFullScreen` × `.crossDissolve` |
| `.popover(backgroundColor: UIColor? = nil)`<br />means the bubble's background color, which you do not change usually. | `.popover`                           |
|                                                              |                                      |

### Create your own style

Inherit `PresentationStyle`, provide you own UIViewController implementation. (Add more explanation later)

## Limitation

- `withAnimation` has no effect on presentation content. Use `animation(_:value:)` instead.

## Roadmap

- [ ] Support sheet detent customization by using iOS 15's new API
- [ ] Use not only `isPresent: Bool`, but also `item: Item?` to determine present the content or not
- [ ] Support the passing of values like Preference and Environment.
- [ ] Add documents

## Contribute

[swift-image]: https://img.shields.io/badge/swift-5.8-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
