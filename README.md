<img src= "https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/57999128-76db-4786-9bb4-981e01c4b154" alt="SwiftUIPresent" title="SwiftUIPresent" height="120">

</br>
</br>

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

SwiftUIPresent is a library helps you present any view or view controller from SwiftUI with enhanced and customized styles, including fade fullscreen cover, popover and more.

| Fade FullscreenCover | Popover |
| -------------------- | ------- |
| ![Fade320](https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/bb55169f-9328-4c14-ae9a-dedf6dff383f) | ![Popover320](https://github.com/Lumisilk/SwiftUIPresent/assets/11924267/52d22f3b-3763-4ef1-be20-cc507438349e) |

## Features

- Introduce the missing fade-in fade-out (crossDissolve) and popover presentation style to SwiftUI.
- Enhance sheet customizability with the background color adjustment from iOS 14 and the height adjustment (detents) API from iOS 15.
- Create your own presentation style and use it in SwiftUI.
- Present any UIViewController from SwiftUI.
- No private APIs or Objective-C
- Supports simultaneous modifications of two data sources and their triggered transitions.
  ```swift
  isFirstSheetPresented = false
  isSecondSheetPresented = true
  ```

## Usage

### Present a SwiftUI view

Use `present(isPresented:style:content:)` for bool presentation control, and `present(item:style:content:)` for optional data binding.

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

#### Built-in styles

| PresentationStyle | The corresponding UIKit styles       |
| ----------------- | ------------------------------------ |
| `.sheet`          | `.pageSheet`                         |
| `.fade`           | `.overFullScreen` × `.crossDissolve` |
| `.popover`        | `.popover`                           |

You can customize the style further using the modifier chain, such as 

```swift
.sheet
    .backgroundColor(.systemGray)
    .detents([.medium()])
    .onDismiss { print("Sheet dismissed") }
```

#### Create your own style

For guidance on crafting your own styles, refer to the built-in style implementations. Conform to `PresentationStyle` and provide your own view controller for presentation.

### Present UIViewController

Use `present(isPresented:viewController:)` or `present(item:viewController)` to present any UIViewController from SwiftUI.

## Requirements

- iOS / iPadOS 14.0+
- Xcode 14.3+

## Installation

### Swift Package Manager

Follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the SwiftUIPresent repo.

`https://github.com/Lumisilk/SwiftUIPresent.git`

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
- [ ] Add an introduction to the extra styles that depend on this repository.

## License
This package is licensed under the MIT open-source license.

The gift icon made by [Freepik](https://www.flaticon.com/free-icon/gift-box_2786395?related_id=2786242) from www.flaticon.com

[swift-image]: https://img.shields.io/badge/swift-5.8-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
