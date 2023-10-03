[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

# SwiftUIPresent

Presenting views from SwiftUI with customized styles, extending beyond sheet and fullscreenCover.

<p align="row">
<img src= "https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/00605e81-4f51-4a06-9cc2-b1a2eb1688f4" width="300" >
<img src= "https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/94f4fabf-348b-4515-b407-9b13f686ebe1" width="300" >
</p>

## Features

- Add the missing fade-in fade-out (crossDissolve) and popover presentation style to SwiftUI.
- Bringing the SwiftUI sheet's height adjustment (detents) API, exclusive to iOS 16, to iOS 15.
- Make your own presentation style and use it in SwiftUI.

## Requirements

- iOS/iPadOS 14.0+
- Xcode 14.3+

## Installation

### Swift Package Manager

Follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the SwiftUIPresent repo with the current version.

`https://github.com/Lumisilk/SwiftUIPresent.git`

## Usage

Use `present(isPresented: Binding<Bool>, style: some PresentationStyle)` for simple bool presentation control,

Or `present<Item: Identifiable>(item: Binding<Item?>, style: some PresentationStyle)` for optional data binding.

```swift
import SwiftUIPresent

struct Example: View {
    @State private var isPresented = false

    var body: some View {
        Button("Present") {
            isPresented = true
        }
        .present(isPresented: $isPresented, style: .fade) {
            Text("Your present content")
        }
    }
}
```

### Built-in styles

| PresentationStyle                                            | The corresponding UIKit styles       |
| ------------------------------------------------------------ | ------------------------------------ |
| `.sheet(detents: [UISheetPresentationController.Detent])`    | `.formSheet`                         |
| `.fade(backgroundColor: UIColor = .clear)`                   | `.overFullScreen` × `.crossDissolve` |
| `.popover(backgroundColor: UIColor? = nil)`<br /> (`backgroundColor` indicates the bubble's background color, which you typically do not change) | `.popover`                           |

### Create your own style

Conforming to  `PresentationStyle`, provide you own UIViewController implementation.

(Will add more explanation later)

## Limitation

- `withAnimation(_:_:)` has no effect on presentation content. Use `animation(_:value:)` modifier instead.

## Roadmap

- [x] Support sheet detent customization by using iOS 15's new API.
- [x] Add optional data binding to control the presentation.
- [ ] Support passing values implicitly like Preference and Environment.
- [ ] Add documents

[swift-image]: https://img.shields.io/badge/swift-5.8-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
