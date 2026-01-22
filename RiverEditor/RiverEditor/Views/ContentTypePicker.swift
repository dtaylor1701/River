import Foundation
import SwiftUI
import RiverKit

struct ContentTypePicker: View {
  @Binding
  var contentType: Artifact.Content
  
  var contentTypes: [Artifact.Content] = [.text, .url, .bool, .number]
  
  var body: some View {
    Picker("Content Type", selection: $contentType) {
      ForEach(contentTypes) { contentType in
        Text(contentType.displayValue)
          .tag(contentType)
      }
    }
  }
}
