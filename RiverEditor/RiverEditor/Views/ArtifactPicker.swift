import SwiftUI
import RiverKit

struct ArtifactPicker: View {
  let artifacts: [Artifact]
  
  @Binding
  var artifactID: ID
  
  var body: some View {
    Picker("Artifact", selection: $artifactID) {
      ForEach(artifacts) { artifact in
        Text(artifact.fileName)
          .tag(artifact.id)
      }
    }
  }
}
