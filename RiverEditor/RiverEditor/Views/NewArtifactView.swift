import Foundation
import SwiftUI
import RiverKit

struct NewArtifactView: View {
  @State
  var filename: String = ""
  
  @State
  var description: String = ""
  
  @State
  var contentType: Artifact.Content = .text
  
  let onAdd: (Artifact) -> Void
  
  var body: some View {
    Form {
      if filename.isEmpty {
        AlertView(message: "Artifact must have file name")
      }
      TextField("Filename", text: $filename)
      TextField("Description", text: $filename)
      ContentTypePicker(contentType: $contentType)
      Section {
        Button {
          onAdd(Artifact(description: description, fileName: filename, contentType: contentType))
        } label: {
          Text("Add artifact")
            .padding(4)
        }
        .disabled(filename.isEmpty)
      }
    }.formStyle(.grouped)
  }
}
