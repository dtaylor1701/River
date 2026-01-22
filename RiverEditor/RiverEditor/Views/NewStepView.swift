import Foundation
import SwiftUI
import RiverKit

struct NewStepView: View {
  @State
  var name: String = ""
  
  let onAdd: (Step) -> Void
  
  var body: some View {
    Form {
      if name.isEmpty {
        AlertView(message: "Step must have a name")
      }
      TextField("Name", text: $name)
      Section {
        Button {
          onAdd(Step(name: name, dependencyIDs: [], actions: []))
        } label: {
          Text("Add artifact")
            .padding(4)
        }
        .disabled(name.isEmpty)
      }
    }.formStyle(.grouped)
  }
}
