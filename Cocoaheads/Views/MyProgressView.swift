//
//  MyProgressView.swift
//  Payday
//
//  Created by Charlie Minow on 4/9/25.
//

import SwiftUI

struct MyProgressView: View {
    var previousMeetingDate: Date
    var nextMeetingDate: Date
    var currentTime: Date

    var body: some View {
        Canvas {context, size in
            let mainRectangle = CGRect(origin: .zero, size: size)
            context.clip(to: Path(roundedRect: mainRectangle, cornerRadius: 8.0))
            context.fill(Path(mainRectangle),
                         with: .linearGradient(redGradient,
                                               startPoint: .zero,
                                               endPoint: CGPoint(x: 0.0, y: size.height)))
            let progressRect: CGRect = CGRect(origin: .zero, size: CGSize(width: size.width * progressPercentage, height: size.height))
//            context.fill(Path(progressRect), with: .color(.green))
            context.fill(Path(progressRect),
                         with: .linearGradient(greenGradient,
                                               startPoint: .zero,
                                               endPoint: CGPoint(x: 0.0, y: size.height))
            )
            
            context.stroke(Path(roundedRect: mainRectangle, cornerRadius: 8.0), with: .color(.gray), style: .init(lineWidth: 1.0))
            
        }
    }
    
    var greenGradient: Gradient {
        let color1: Color = Color(red: 0.0, green: 1.0, blue: 0.0)
        let color3: Color = Color(red: 0.10, green: 0.75, blue: 0.30)
        return Gradient(stops: [.init(color: color1, location: 0.0),
                                .init(color: color3, location: 1.0)]
        )
    }

    var redGradient: Gradient {
        let color1: Color = Color(red: 0.75, green: 0.10, blue: 0.30)
        let color3: Color = Color(red: 1.0, green: 0.0, blue: 0.0)
        return Gradient(stops: [.init(color: color1, location: 0.0),
                                .init(color: color3, location: 1.0)]
        )
    }

    var progressPercentage: Double {
        return (currentTime.timeIntervalSinceReferenceDate - previousMeetingDate.timeIntervalSinceReferenceDate) / (nextMeetingDate.timeIntervalSinceReferenceDate - previousMeetingDate.timeIntervalSinceReferenceDate)
    }
}

#Preview {
    MyProgressView(previousMeetingDate: .now - 86_400, nextMeetingDate: .now + 86_400, currentTime: .now)
}
