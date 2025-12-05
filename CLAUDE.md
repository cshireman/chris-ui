# ChrisUI - SwiftUI Component Library

## Project Overview

ChrisUI is a comprehensive collection of reusable SwiftUI components designed to accelerate iOS app development. This library provides production-ready, customizable components that follow Apple's Human Interface Guidelines and modern SwiftUI best practices.

## Project Goals

- Provide plug-and-play SwiftUI components for common UI patterns
- Maintain consistency across iOS applications
- Reduce development time for standard UI implementations
- Follow accessibility best practices
- Support iOS 16+ with modern SwiftUI features
- Leverage iOS 26 Liquid Glass effects for modern, fluid interfaces
- Maintain clean, well-documented, and testable code

## Architecture

The library is organized into feature-based modules, with each component:
- Living in its own directory under `Sources/Components/`
- Including examples and documentation
- Supporting customization through modifiers and configuration
- Following the single responsibility principle

## Planned Component Categories

### 1. Authentication & Onboarding
- **Login Screen** - Email/password login with validation
- **Sign Up Form** - Multi-step registration flow
- **Social Auth Buttons** - Apple, Google, Facebook sign-in buttons
- **Forgot Password** - Password reset flow
- **Biometric Auth** - Face ID / Touch ID integration
- **Onboarding Flow** - Paginated welcome screens with skip/next navigation
- **Tutorial Overlays** - Feature highlights and guided tours
- **Terms & Conditions** - Scrollable legal text with acceptance

### 2. Forms & Input
- **Custom Text Fields** - Styled text input with validation states
- **Floating Label Input** - Material design-style inputs
- **Search Bar** - Dismissible search with suggestions
- **OTP Input** - One-time password entry fields
- **Date Picker Field** - Inline and modal date selection
- **Dropdown Selector** - Custom picker with search
- **Tag Input** - Multi-select tag chips
- **Slider with Labels** - Range selector with value display
- **Rating Input** - Star/heart rating component
- **Form Validator** - Reusable validation logic

### 3. Lists & Collections
- **Pull to Refresh List** - Custom refresh control
- **Infinite Scroll List** - Lazy loading pagination
- **Swipeable List Row** - Delete/edit actions
- **Expandable List** - Accordion-style sections
- **Grid Layout** - Responsive grid with custom sizing
- **Horizontal Scroll Picker** - Netflix-style carousels
- **Reorderable List** - Drag-to-reorder items
- **Empty State View** - Placeholder for empty lists

### 4. Cards & Containers
- **Card View** - Elevated container with shadow
- **Profile Card** - User info display
- **Product Card** - E-commerce item display
- **News Card** - Article preview with image
- **Stats Card** - Metrics and KPI display
- **Expandable Card** - Collapsible content card
- **Flip Card** - Animated front/back card
- **Glassmorphism Card** - Frosted glass effect with iOS 26 Liquid Glass support

### 5. Navigation & Tabs
- **Custom Tab Bar** - Animated bottom navigation
- **Floating Action Button** - Material-style FAB
- **Segmented Control** - Custom segment picker
- **Breadcrumb Navigation** - Hierarchical path display
- **Side Menu** - Drawer navigation
- **Bottom Sheet** - Modal drawer from bottom
- **Navigation Bar** - Custom nav with actions
- **Page Control** - Custom page indicators

### 6. Feedback & Notifications
- **Toast Notifications** - Temporary message overlays
- **Alert Dialogs** - Custom alert styles
- **Loading Indicators** - Spinners and progress views
- **Progress Bars** - Linear and circular progress
- **Skeleton Screens** - Loading placeholders
- **Banner Notifications** - Top banner messages
- **Snackbar** - Bottom notification with action
- **Confetti Animation** - Success celebration effect

### 7. Media & Content
- **Image Carousel** - Swipeable image gallery
- **Video Player Controls** - Custom playback UI
- **Audio Waveform** - Audio visualization
- **PDF Viewer** - Document display
- **Image Picker** - Photo selection with crop
- **Avatar View** - Profile images with fallbacks
- **Photo Grid** - Instagram-style photo layout
- **Zoom Image View** - Pinch-to-zoom images

### 8. Buttons & Actions
- **Gradient Button** - Animated gradient backgrounds
- **Icon Button** - Circular icon actions
- **Toggle Button** - Binary selection button
- **Button Group** - Multiple choice buttons
- **Chip Button** - Pill-shaped action buttons
- **Expandable FAB** - Speed dial actions
- **3D Touch Button** - Haptic feedback buttons
- **Loading Button** - Button with loading state

### 9. Charts & Visualizations
- **Line Chart** - Time series data
- **Bar Chart** - Comparative bar graphs
- **Pie Chart** - Percentage breakdowns
- **Donut Chart** - Ring-style metrics
- **Progress Ring** - Circular progress indicator
- **Sparkline** - Compact trend lines
- **Gauge View** - Speedometer-style meter
- **Heat Map** - Grid-based data visualization

### 10. Settings & Preferences
- **Settings List** - Grouped preference items
- **Toggle Setting** - Switch with description
- **Stepper Setting** - Numeric adjustment
- **Picker Setting** - Selection from options
- **Slider Setting** - Range value adjustment
- **Color Picker** - Color selection tool
- **Font Size Picker** - Accessibility text sizing
- **Theme Selector** - Dark/light mode toggle

### 11. Social & Sharing
- **Comment Thread** - Nested comments display
- **Like Button** - Animated heart/thumbs up
- **Share Sheet** - Native sharing integration
- **User Mention** - @username autocomplete
- **Hashtag Input** - #tag formatting
- **Reaction Picker** - Emoji reaction selector
- **Follow Button** - Follow/unfollow with count
- **Social Stats** - Likes, shares, views display

### 12. Calendar & Scheduling
- **Month Calendar** - Full month view
- **Week View** - 7-day schedule
- **Date Range Picker** - Start/end date selection
- **Time Slot Picker** - Appointment booking
- **Event Card** - Calendar event display
- **Availability Grid** - Time slot availability
- **Countdown Timer** - Event countdown display

### 13. E-commerce
- **Product Grid** - Shopping item layout
- **Add to Cart Button** - Animated cart action
- **Quantity Selector** - Plus/minus stepper
- **Price Tag** - Formatted price display
- **Discount Badge** - Sale/discount indicator
- **Size Selector** - Product size picker
- **Color Swatch** - Color option picker
- **Checkout Progress** - Multi-step indicator
- **Order Status** - Delivery tracking view

### 14. Utility Components
- **Badge** - Notification count badge
- **Tag Cloud** - Keyword collection display
- **Divider** - Custom section separators
- **Spacer Grid** - Layout debugging tool
- **Safe Area Helper** - Edge inset utilities
- **Conditional Wrapper** - Modifier helper
- **View If** - Conditional rendering helper
- **Shimmer Effect** - Loading shimmer animation

## Development Guidelines

### Code Style
- Use Swift 5.9+ features
- Follow SwiftLint rules
- Document all public APIs
- Include code examples in documentation

### Component Requirements
Each component should:
1. Be self-contained and reusable
2. Support customization via modifiers or init parameters
3. Include accessibility labels and traits
4. Support Dynamic Type
5. Work in both light and dark modes
6. Include a preview with multiple examples
7. Have unit tests where applicable

### File Structure
```
ChrisUI/
├── Sources/
│   ├── Components/
│   │   ├── Authentication/
│   │   ├── Forms/
│   │   ├── Lists/
│   │   └── ...
│   ├── Modifiers/
│   ├── Styles/
│   └── Utilities/
├── Examples/
├── Tests/
└── Documentation/
```

## Getting Started

### Installation
[To be added: Swift Package Manager instructions]

### Usage
[To be added: Basic usage examples]

## Contributing

When adding new components:
1. Create a new directory under the appropriate category
2. Include the component file with clear documentation
3. Add examples to the Examples app
4. Update this CLAUDE.md file with component description
5. Write tests for complex logic
6. Ensure accessibility support

## Roadmap

### Phase 1: Foundation (Current)
- Set up project structure
- Create basic authentication components
- Build core form inputs
- Implement common buttons and cards

### Phase 2: Enhanced Features
- Add advanced list components
- Build chart and visualization components
- Create e-commerce components

### Phase 3: Polish
- Add comprehensive documentation
- Create demo app with all components
- Performance optimization
- Accessibility audit

## License
[To be determined]

## Contact
[To be added]
