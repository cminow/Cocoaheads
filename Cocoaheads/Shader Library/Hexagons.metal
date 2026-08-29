//
//  Hexagons.metal
//  Furnace Info
//
//  Created by Charlie Minow on 8/26/26.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 hexPixelateLayer(
    float2 position,
    SwiftUI::Layer layer,
    float2 size, // 💡 Pass the view boundaries
    float scale
) {
    float2 r = float2(1.0, 1.7320508) * scale;
    float2 h = r * 0.5;
    
    float2 a = floor((position - h) / r) * r + h;
    float2 b = floor(position / r) * r;
    
    float2 distA = position - (a + h);
    float2 distB = position - (b + h);
    float2 center = dot(distA, distA) < dot(distB, distB) ? (a + h) : (b + h);
    
    // 💡 CRITICAL FIX: Clamp the center coordinates inside the view bounds.
    // Subtracting a tiny fraction (0.5) ensures it never samples exactly on the boundary pixel.
    float2 clampedCenter = clamp(center, float2(0.5), size - float2(0.5));

    half4 sampledColor = layer.sample(clampedCenter);

    return sampledColor;
}


