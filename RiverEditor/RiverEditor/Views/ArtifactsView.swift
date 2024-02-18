//
//  ArtifactsView.swift
//  RiverEditor
//
//  Created by David Taylor on 11/22/23.
//

import Foundation
import SwiftUI
import RiverKit

struct ArtifactsView: View {
  @Binding
  var artifacts: [Artifact]
  
  @Binding
  var selected: Artifact?
  
  var body: some View {
    List {
      ForEach(artifacts) { artifact in
        Button {
          selected = artifact
        } label: {
          ArtifactCard(artifact: artifact)
            .asListButtonContent(isSelected: artifact == selected)
        }
        .buttonStyle(.plain)
      }
    }
  }
}

struct ArtifactCard: View {
  let artifact: Artifact
  
  var body: some View {
    Text(artifact.fileName)
  }
}
