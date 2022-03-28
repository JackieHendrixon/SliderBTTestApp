//
//  TestChangePosition.swift
//  SliderBTSDKTestApp
//
//  Created by Frankie on 18/03/2022.
//

import SwiftUI
import SliderBluetoothSDK

struct TestChangePosition: View {

    let sliderBT: SliderBluetoothSDK?
    @State var slide: Double = 0
    @State var pan: Double = 0
    @State var tilt: Double = 0

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Slide:")
                Text(String(format: "%.1f", slide))
            }
            Slider(value: $slide, in: 0...100)
            HStack {
                Text("Pan:")
                Text(String(format: "%.1f", pan))
            }
            Slider(value: $pan, in: 0...100)
            HStack {
                Text("Tilt:")
                Text(String(format: "%.1f", tilt))
            }
            Slider(value: $tilt, in: 0...100)
            Button(action: {
                print("positions:", slide, pan, tilt)
                sliderBT?.slider.changePosition(
                    .init(slide: UInt16(slide * Double(UINT16_MAX) / 100),
                          pan: UInt16(pan * Double(UINT16_MAX) / 100),
                          tilt: UInt16(tilt * Double(UINT16_MAX) / 100))
                )
            }, label: {
                Text("Send")
            })
            LoggerView()
        }
        .padding(.horizontal, 24)
        .navigationTitle("Test ChangePosition")
    }
}

struct TestChangePosition_Preview: PreviewProvider {
    static var previews: some View {
        TestChangePosition(sliderBT: nil)
    }
}
