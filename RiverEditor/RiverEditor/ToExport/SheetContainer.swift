//
//  SheetContainer.swift
//  RiverEditor
//
//  Created by David Taylor on 2/17/24.
//

import Foundation
import SwiftUI

public struct SheetContainer: ViewModifier {
  @Environment(\.dismiss)
  private var dismiss
  
  public func body(content: Content) -> some View {
    VStack {
      content
      Button {
        dismiss()
      } label: {
        Text("Done")
      }
      .buttonStyle(.bordered)
      .padding()
    }
    .frame(minWidth: 200, minHeight: 300)
  }
}

public extension View {
  func asSheet() -> some View {
    modifier(SheetContainer())
  }
}
