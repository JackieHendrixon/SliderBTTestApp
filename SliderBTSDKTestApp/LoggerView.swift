//
//  LoggerView.swift
//  SliderBTSDKTestApp
//
//  Created by Frankie on 28/03/2022.
//

import SwiftUI
import Combine
import SliderBluetoothSDK

struct LoggerView: View {
    @State private var logs: [Log] = []

    var body: some View {
        ScrollViewReader { value in
            ScrollView {
                LazyVStack(spacing: 4){
                    ForEach(logs, id: \.self) { log in
                        Text(log.value)
                            .id(log.id)
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .frame(height: 160)
            .onChange(of: logs.count) { _ in
                value.scrollTo(logs.last?.id)
            }
            .onReceive(Logger.loggerPublisher) { value in
                logs.append(Log(value: value))
            }
        }
    }
}

private struct Log: Identifiable, Hashable {
    let id = UUID()
    var value: String
}
