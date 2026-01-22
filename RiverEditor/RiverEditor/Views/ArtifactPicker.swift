import SwiftUI
import RiverKit

struct ArtifactPicker: View {
  let title: String
  let artifacts: [Artifact]
  
  @Binding
  var artifactID: Artifact.ID
  
  init(title: String = "Artifact",
       artifacts: [Artifact],
       artifactID: Binding<Artifact.ID>) {
    self.title = title
    self.artifacts = artifacts
    self._artifactID = artifactID
  }
  
  var body: some View {
    Picker(title, selection: $artifactID) {
      ForEach(artifacts) { artifact in
        Text(artifact.fileName)
          .tag(artifact.id)
      }
    }
  }
}
