//
//  SelectArtifactView.swift
//  RiverEditor
//
//  Created by David Taylor on 2/16/24.
//

import Foundation
import SwiftUI
import RiverKit


struct SelectArtifactView: View {
  let artifacts: [Artifact]
  
  let didSelect: (Artifact) -> Void
  
  @Environment(\.dismiss)
  var dismiss
  
  var body: some View {
    List {
      ForEach(artifacts) { artifact in
        Button {
          dismiss()
          didSelect(artifact)
        } label: {
          VStack {
            Text(artifact.fileName)
            Text(artifact.description)
              .font(.caption)
          }
          .asListButtonContent()
        }
        .buttonStyle(.plain)
      }
    }
  }
}
