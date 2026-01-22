import Foundation
import SwiftUI
import RiverKit
import BlueJay

struct EditArtifactView: View {
  @Binding
  var artifact: Artifact
  
  @Binding
  var flow: Flow
  
  var title: String {
    "Edit Artifact"
  }
  
  var contentTypes: [Artifact.Content] = [.text, .url, .bool, .number]
  
  var body: some View {
    Form {
      TextField("File name", text: $artifact.fileName)
      TextField("Description", text: $artifact.description)
      ContentTypePicker(contentType: $artifact.contentType)
      DeleteButton(item: artifact, array: $flow.artifacts)
    }
    .formStyle(.grouped)
  }
}
