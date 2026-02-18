//
//  ServerChartView.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 18.02.26.
//

import SwiftUI
import Charts

struct ChartSample {
    var time: Date
    var metric: String
    var value: Double
}

struct ServerChartView: View {
    
    @EnvironmentObject private
    var authentication: AuthenticationModel
    
    @StateObject private
    var viewModel: ServerGraphViewModel = .init()
    
    var server: Server
    
    private func normalize(_ values: [Double]) -> [Double] {
        let max = values.max() ?? 1
        guard max > 0 else { return values.map { _ in 0 } }
        return values.map { $0 / max }
    }
    
    private func chartData(from samples: [ServerGraph]) -> [ChartSample] {
        let cpu = normalize(samples.map(\.processor))
        let ram = samples.map { $0.memory / max($0.maximumMemory, 1) }
        let diskWrite = normalize(samples.map(\.diskWrite))
        let netIn = normalize(samples.map(\.networkIncoming))

        var result: [ChartSample] = []
        for (i, s) in samples.enumerated() {
            result += [
                .init(time: s.time, metric: "CPU", value: cpu[i]),
                .init(time: s.time, metric: "RAM", value: ram[i]),
                .init(time: s.time, metric: "Schreiben", value: diskWrite[i]),
                .init(time: s.time, metric: "Eingehend", value: netIn[i])
            ]
        }
        return result
    }
    
    var body: some View {
        ZStack {
            if let samples = viewModel.samples {
                let data = chartData(from: samples)
                Chart {
                    ForEach(data, id: \.time) { point in
                        LineMark(
                            x: .value("Zeit", point.time),
                            y: .value("Wert", point.value)
                        )
                        .foregroundStyle(by: .value("Metrik", point.metric))
                        .interpolationMethod(.catmullRom)
                        .lineStyle(StrokeStyle(lineWidth: 1.5))
                    }
                }
                .chartYScale(domain: 0...1)
                .chartYAxis(.hidden)
                .chartXAxis(.visible)
                .chartForegroundStyleScale([
                    "CPU": Color.blue,
                    "RAM": Color.green,
                    "Schreiben": Color.orange,
                    "Eingehend": Color.purple
                ])
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.fetch(
                session: authentication.session,
                server: server
            )
        }
        .onReceive(Upstream.refreshed) { _ in
            print("[ DEBUG ] refreshing chart …")
            Task {
                await viewModel.fetch(
                    session: authentication.session,
                    server: server
                )
            }
        }
    }
}
