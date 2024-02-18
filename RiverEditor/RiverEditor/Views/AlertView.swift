import Foundation
import SwiftUI

struct AlertView: View {
  let message: String
  
  var body: some View {
    Label {
      Text(message)
    } icon: {
      Image(systemName: "exclamationmark.triangle")
    }
    .foregroundColor(.red)
  }
}
