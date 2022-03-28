//
//  TestChangePosition.swift
//  SliderBTSDKTestApp
//
//  Created by Frankie on 18/03/2022.
//

import SwiftUI
import SliderBluetoothSDK

struct TestMove: View {

    let sliderBT: SliderBluetoothSDK?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var slide: Double = 0
    @State var pan: Double = 0
    @State var tilt: Double = 0
    @State var sendingFrequency: Double = 0
    @State var isTimerOn: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            Toggle("Timer", isOn: $isTimerOn)
            HStack {
                Text("Slide:")
                Text(String(format: "%.1f", slide))
            }
            Slider(value: $slide, in: -100...100)
            HStack {
                Text("Pan:")
                Text(String(format: "%.1f", pan))
            }
            Slider(value: $pan, in: -100...100)
            HStack {
                Text("Tilt:")
                Text(String(format: "%.1f", tilt))
            }
            Slider(value: $tilt, in: -100...100)
            Button(action: {
                print("Raw positions:", slide, pan, tilt)
                sliderBT?.slider.move(convertPercentToInt16(slide), axis: .slide)
                sliderBT?.slider.move(convertPercentToInt16(pan), axis: .pan)
                sliderBT?.slider.move(convertPercentToInt16(tilt), axis: .tilt)
            }, label: {
                Text("Send")
            })
            Button(action: {
                isTimerOn = false
                sliderBT?.slider.move(0, axis: .slide)
                sliderBT?.slider.move(0, axis: .pan)
                sliderBT?.slider.move(0, axis: .tilt)
            }, label: {
                Text("Stop")
            })
            LoggerView()
        }
        .padding(.horizontal, 24)
        .navigationTitle("Test Move")
        .onDisappear() {
            timer.upstream.connect().cancel()
        }
        .onReceive(timer) { _ in
            if self.isTimerOn {//, timerTick % 100 == 0 {
                sliderBT?.slider.move(convertPercentToInt16(slide), axis: .slide)
                sliderBT?.slider.move(convertPercentToInt16(pan), axis: .pan)
                sliderBT?.slider.move(convertPercentToInt16(tilt), axis: .tilt)
            }
            //                    timerTick += 1
        }


    }
}

private func convertPercentToInt16(_ percentValue: Double) -> Int16 {
    return Int16(percentValue * Double(INT16_MAX) / 100)
}

struct TestCTestMove_Preview: PreviewProvider {
    static var previews: some View {
        TestChangePosition(sliderBT: nil)
    }
}
