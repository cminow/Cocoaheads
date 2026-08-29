//
//  View.swift
//  Cocoaheads
//
//  Created by Charlie Minow on 8/29/26.
//

import SwiftUI

extension View {
    func hexPixellateLayer(scale: Float = 8) -> some View {
        modifier(HexPixellateLayer(scale: scale))
    }
}

struct HexPixellateLayer: ViewModifier {
    let scale: Float

    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content.layerEffect(
                ShaderLibrary.hexPixelateLayer(
                    .float2(proxy.size),
                    .float(scale)
                ),
                maxSampleOffset: .zero)
        }
    }
}
