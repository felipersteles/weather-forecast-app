
<img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXedfexJqHQUot9YdQ8P4iJqB1N0vGOvnNDlvGGnTM9C9MfeQs6M_NCdgXZvJmf-6IKEzEZSYk0J1u_RFMX868-licdy1ashJ3LAdbAHcInmOWinSuIqToAVoynFirSYQk9zuO_M4lA5gK/s1600/vanitas.jpg" height="400" width="100%"/>

# 🌦 Weather Forecast iOS App  

A sleek, intuitive weather app built in **Swift** for iOS, delivering real-time forecasts, 5-day predictions, and dynamic weather visuals—my very first Swift project!

Designed with simplicity and functionality in mind, this app showcases my journey into iOS development, combining clean UI design with practical weather data integration. Whether you're checking the current temperature or planning ahead with detailed hourly updates, this app keeps you informed in style.

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-orange?logo=swift" alt="Swift Version">
  <img src="https://img.shields.io/badge/iOS-15%2B-blue?logo=apple" alt="iOS 15+">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
</p>

## Features  

- **Real-Time Weather** – Temperature, humidity, wind speed, and UV index.  
- **5-Day Forecast** – Hourly and daily predictions.  
- **Dynamic UI** – Backgrounds adapt to weather conditions (sunny, rainy, etc.).  

## Tech Stack  

- **Swift 5** UIKit or SwiftUI
- **Weather API** OpenWeatherMap

## System Concepts Learned

In this section, I will explain some concepts from iOS development in Swift.

### App Delegate
The **App Delegate** is the starting point of an iOS app. It responds to key events in the app's lifecycle, such as launching, entering the background, or terminating. It implements the `UIApplicationDelegate` protocol and is responsible for tasks like:
- Configuring the app on launch (`application(_:didFinishLaunchingWithOptions:)`)
- Registering for push notifications
- Handling background fetches or state restoration

### Scene Delegate
The **Scene Delegate** was introduced in iOS 13 to handle multiple scenes (windows) in an app. It works alongside the App Delegate to manage UI-related lifecycle events, such as:
- Creating and configuring the main window
- Responding to scene lifecycle events like entering the foreground or background
- Supporting multiple window instances in iPadOS or macOS Catalyst apps

The main method here is `scene(_:willConnectTo:options:)`, where you attach the root view controller to the window.

---

## View Controller Concepts

In this section, I will explain the concepts that are present in each screen.

### Lazy var
A **lazy var** is a property whose initial value is not calculated until the first time it is used. This is useful for heavy or complex objects (like UI elements or network managers) that should only be created when needed. In Swift, it's declared with the `lazy` keyword. For example:

```swift
lazy var myLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello, world"
    return label
}()
```

### Constraints

Constraints are used in Auto Layout to define the size and position of UI elements relative to each other or to the parent view. They allow you to create adaptive layouts that work across different screen sizes. Constraints can define relationships like:

- Leading, trailing, top, bottom spacing
- Width and height
- Centering elements
- Aspect ratio
- Constraints can be added via Interface Builder or programmatically using NSLayoutConstraint or layout anchors.

### Stack View
A **UIStackView** is a container view that automatically arranges its child views in a horizontal or vertical line. It simplifies layout by managing the spacing, alignment, and distribution of views. Stack views are great for building flexible and responsive interfaces without writing a lot of layout code.

Key properties include:

- axis (horizontal or vertical)
- alignment (leading, center, etc.)
- distribution (fill, fillEqually, etc.)
- spacing (space between items)

### Collection View

A **UICollectionView** is a powerful and flexible view for displaying data in a grid or custom layout. It works similarly to a table view but offers more layout customization. You use it to display items like images, cards, or any repeated content.

Main components include:

- **UICollectionViewCell**: the reusable item displayed in the view
- **UICollectionViewFlowLayout**: a layout object to define item size, spacing, and scroll direction
- **Data Source**: provides the number of items and configures each cell
- **Delegate**: handles user interaction like selection or scrolling









