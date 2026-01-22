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
  let step: Step
  let flow: Flow
  let onAdd: (Artifact.ID) -> Void
  
  var body: some View {
    if let firstArtifact = flow.artifacts.first(where: { !step.has(dependency:$0) }) {
      AddDependencyViewContent(artifactID: firstArtifact.id, step: step, flow: flow, onAdd: onAdd)
    } else {
      AlertView(message: "Add artifacts to assign them as dependencies.")
    }
  }
}

private struct AddDependencyViewContent: View {
  @State
  var artifactID: Artifact.ID
  let step: Step
  let flow: Flow
  let onAdd: (Artifact.ID) -> Void
  
  var eligibleArtifacts: [Artifact] {
    flow.artifacts.filter({ !step.has(dependency: $0) })
  }
  
  var body: some View {
    HStack {
      ArtifactPicker(artifacts: eligibleArtifacts, artifactID: $artifactID)
      Button {
        onAdd(artifactID)
      } label: {
        Label {
          Text("Add")
        } icon: {
          Image(systemName: "plus")
        }
        .padding(4)
      }
    }
  }
}

extension Step {
  func has(dependency: Artifact) -> Bool {
    dependencyIDs.contains(dependency.id)
  }
}
