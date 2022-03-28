//
//  ContentView.swift
//  SliderBTSDKTestApp
//
//  Created by Frankie on 09/03/2022.
//

import SwiftUI
import SliderBluetoothSDK

struct ContentView: View {
    private let sliderBT = SliderBluetoothSDK()

    @State private var instruction = ""
    @State private var data = ""

    var body: some View {
        NavigationView {
            VStack(spacing:48) {

                Button(action: {
                    sliderBT.start()
                }, label: {
                    Text("Start scanning")
                })
                HStack(spacing: 24) {
                    TextField("Instruction", text: $instruction)
                        .frame(width: 120)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Data", text: $data)
                        .frame(width: 120)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numbersAndPunctuation)
                    Button(action: {
                        guard !instruction.isEmpty else { return }
                        var sendData = Data()
                        var dataUInt8 = UInt8(instruction)
                        let byteData = Data(bytes: &dataUInt8,
                                            count: 1)
                        sendData.append(byteData)
                        if !data.isEmpty {
                            var dataInt16 = Int16(data)
                            let byteData = Data(bytes: &dataInt16, count: 2)
                            sendData.append(byteData)
                        }
                        sendData.forEach {
                            print(String($0, radix: 2))
                        }
                        sliderBT.write(value: sendData)
                    }, label: {
                        Text("Send")
                    })
                }
                NavigationLink (
                    "Test ChangePosition",
                    destination: TestChangePosition(sliderBT: sliderBT)
                )
                NavigationLink (
                    "Test Move",
                    destination: TestMove(sliderBT: sliderBT)
                )
                Button(action: {
                    sliderBT.disconnect()
                }, label: {
                    Text("Disconnect")
                })
                LoggerView()
            }.buttonStyle(.bordered)
                .navigationTitle("Slider BT Test App 🔬")
        }
        .tint(.red)
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
