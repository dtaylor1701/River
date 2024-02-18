//
//  AddActionView.swift
//  RiverEditor
//
//  Created by David Taylor on 2/17/24.
//

import Foundation
import SwiftUI
import RiverKit

struct AddActionView: View {
  let flow: Flow
  let onAdd: (Action) -> Void
  
  var body: some View {
    if let firstArtifact = flow.artifacts.first {
      AddActionViewContent(artifactID: firstArtifact.id, flow: flow, onAdd: onAdd)
    } else {
      AlertView(message: "Actions require artifacts as output.")
    }
  }
}

private struct AddActionViewContent: View {
  @State
  var actionType: ActionTypePicker.ActionType = .collect
  
  @State
  var artifactID: ID
  
  let flow: Flow
  
  let onAdd: (Action) -> Void
  
  var body: some View {
    HStack {
      ActionTypePicker(actionType: $actionType)
      ArtifactPicker(artifacts: flow.artifacts, artifactID: $artifactID)
      Button {
        switch actionType {
        case .collect:
          onAdd(.collect(CollectAction(name: "", outputArtifactID: artifactID)))
        case .execute:
          onAdd(.execute(ExecuteAction(name: "", executablePath: "", arguments: [], outputArtifactID: artifactID)))
        }
      } label: {
        Text("Add action")
      }
    }
  }
}
