//
//  ContentView.swift
//  RiverEditor
//
//  Created by David Taylor on 10/23/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: RiverEditorDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(RiverEditorDocument()))
}
