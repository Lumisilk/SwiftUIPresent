[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

# SwiftUIPresent

Present views from SwiftUI with enhanced and customized styles, extending beyond sheet and fullscreenCover.

<p align="row">
<img src= "https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/00605e81-4f51-4a06-9cc2-b1a2eb1688f4" width="300" >
<img src= "https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/94f4fabf-348b-4515-b407-9b13f686ebe1" width="300" >
</p>

## Features

- Introduce the missing fade-in fade-out (crossDissolve) and popover presentation style to SwiftUI.
- Enhance sheet customizability with the background color adjustment API for iOS 14 and the height adjustment (detents) API for iOS 15.
- Create your own presentation style and use it in SwiftUI.
- No private APIs or Objective-C

## Requirements

- iOS / iPadOS 14.0+
- Xcode 14.3+

## Installation

### Swift Package Manager

Follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the SwiftUIPresent repo.

`https://github.com/Lumisilk/SwiftUIPresent.git`

## Usage

Use `present(isPresented:style:content:)` for straightforward bool presentation control,

And `present(item:style:content:)` for optional data binding.

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

| PresentationStyle | The corresponding UIKit styles       |
| ----------------- | ------------------------------------ |
| `.sheet`          | `.pageSheet`                         |
| `.fade`           | `.overFullScreen` × `.crossDissolve` |
| `.popover`        | `.popover`                           |

You can customize the style further using the modifier chain, such as `.sheet.backgroundColor(.systemGray).detents([.medium()])`.

### Create your own style

For guidance on crafting your own styles, refer to the built-in style implementations. Conform to `PresentationStyle` and provide your own view controller for presentation.

## Limitation

Here are some limitations and potential issues you might encounter while using SwiftUIPresent.
If you discover new issues, or know solutions for the existing ones, please submit an issue or create a PR.

### Animation

When the value that triggers the animation lies outside of the content view closure, `withAnimation(_:_:)` won't have an effect on the presented content. 

Instead, use the `animation(_:value:)` modifier or extract the content into a separate view that holds the relevant values.

### Implicit value passing

Passing values implicitly from the outside in via `Environment` or from the inside out via `Preference` in view content closures is not supported. This includes properties like `foregroundColor`, `navigationTitle`, and so on.

> While it's technically possible to pass all values through the Environment. But it's not always suitable because not every value should be passed. For example, when content is presented modally, the system sets the text color of the buttons on the background view to gray. If all `Environment` values were passed along, the button on the presented content would also turn gray, which is not desired. Because it's challenging to determine which values to pass and which to exclude, it's recommended to explicitly set the values for the presented content.

### Present from the start

When using the popover style, setting isPresented to true before the view has appeared may lead to incorrect behavior. Consider delaying the assignment by using `onAppear` combined with either `Task` or `DispatchQueue`.

## To-do

- [x] Add documents
- [ ] Support dismiss from the presented content itself.
- [ ] Add optional  `onDismiss` argument to sheet and popover styles.
- [ ] Make a icon and some more beautiful preview images.
- [ ] Add an introduction to the extra styles that depend on this repository.

[swift-image]: https://img.shields.io/badge/swift-5.8-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
