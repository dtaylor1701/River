//
//  AddActionView.swift
//  RiverEditor
//
//  Created by David Taylor on 2/17/24.
//

import Foundation
import SwiftUI
import RiverKit

struct AddDependencyView: View {
  let flow: Flow
  let onAdd: (Artifact.ID) -> Void
  
  var body: some View {
    if let firstArtifact = flow.artifacts.first {
      AddDependencyViewContent(artifactID: firstArtifact.id, flow: flow, onAdd: onAdd)
    } else {
      AlertView(message: "Add artifacts to assign them as dependencies.")
    }
  }
}

private struct AddDependencyViewContent: View {
  @State
  var artifactID: Artifact.ID
  
  let flow: Flow
  
  let onAdd: (Artifact.ID) -> Void
  
  var body: some View {
    HStack {
      ArtifactPicker(artifacts: flow.artifacts, artifactID: $artifactID)
      Button {
        onAdd(artifactID)
      } label: {
        Text("Add Dependency")
      }
    }
  }
}
