# New Color Access Syntax

The NeoBrutalistUI library now supports ergonomic color access without needing to use `@Environment` for theme colors.

## Old Pattern

```swift
struct MyView: View {
    @Environment(\.neoBrutalistTheme) private var theme

    var body: some View {
        Text("Hello")
            .foregroundColor(theme.textPrimary.color)
            .background(theme.surface.primary.color)
    }
}
```

## New Pattern

```swift
struct MyView: View {
    var body: some View {
        Text("Hello")
            .foregroundStyle(.nb.textPrimary)
            .background(.nb.surface.primary)
    }
}
```

## Available Colors

### Palettes (with primary, secondary, highlight variants)
- `.nb.background.primary` / `.secondary` / `.highlight`
- `.nb.surface.primary` / `.secondary` / `.highlight`
- `.nb.accent.primary` / `.secondary` / `.highlight`

### Text Colors
- `.nb.textPrimary`
- `.nb.textMuted`

## Usage with Modifiers

### Fills and Strokes
```swift
Circle()
    .fill(.nb.accent.primary)
    .stroke(.nb.accent.highlight, lineWidth: 2)
```

### Foreground Styles
```swift
Text("Title")
    .foregroundStyle(.nb.textPrimary)

Image(systemName: "star")
    .foregroundStyle(.nb.accent.highlight)
```

### Backgrounds
```swift
VStack {
    // content
}
.background(.nb.surface.primary)
```

### With Opacity
```swift
Rectangle()
    .fill(.nb.surface.secondary.opacity(0.5))
```

## Notes

- Use `.foregroundStyle()` instead of `.foregroundColor()` with the new syntax
- Colors dynamically read from the current theme in the environment
- Theme switching continues to work automatically
- You still need `@Environment(\.neoBrutalistTheme)` for non-color theme properties like typography, spacing, borderWidth, etc.
