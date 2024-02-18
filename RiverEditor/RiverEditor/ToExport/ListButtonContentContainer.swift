import SwiftUI

public struct ListButtonContentContainer: ViewModifier {
  let isSelected: Bool
  
  public func body(content: Content) -> some View {
    HStack {
      content
      Spacer()
    }
    .contentShape(Rectangle())
    .padding(4)
    .background(isSelected ? Color.accentColor : Color.clear)
    .clipShape(RoundedRectangle(cornerRadius: 4.0))
  }
}

public extension View {
  func asListButtonContent(isSelected: Bool? = nil) -> some View {
    modifier(ListButtonContentContainer(isSelected: isSelected ?? false))
  }
}
