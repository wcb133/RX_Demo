//
//  RxDemoWidget.swift
//  RxDemoWidget
//
//  Created by Weicb on 2022/8/29.
//  Copyright © 2022 fst. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let item = SimpleModel(name: "张全蛋placeholder", age: 19)
        return SimpleEntry(date: Date(), model: item)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let item = SimpleModel(name: "李小龙getSnapshot", age: 25)
        let entry = SimpleEntry(date: Date(), model: item)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for k in 1..<50 {
            let entryDate = Calendar.current.date(byAdding: .second, value: k, to: currentDate)!
            let item = SimpleModel(name: "李小龙", age: 25 + k)
            let entry = SimpleEntry(date: entryDate, model: item)
            entries.append(entry)
        }
        // atEnd：所有entries显示完之后才刷新
        // after(date)：指定刷新时间
        // never：不刷新
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)

//        let currentDate = Date()
//        let entryDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
//        //模拟网络请求，如果第一次网络请求时间太长，组件会空白一段时间
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//           let item = SimpleModel(name: "李小龙-网络", age: 55)
//           let entry = SimpleEntry(date: entryDate, model: item)
//            let timeLine = Timeline(entries: [entry], policy: .after(entryDate))
//            completion(timeLine)
//        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let model: SimpleModel
}

struct SimpleModel {
    var name: String
    var age: Int
}

struct RxDemoWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Link(destination: URL(string: "跳转url") ?? URL(string: "www.baidu.com")!) {
            Text(entry.date, style: .time)
        }

        Text("\(entry.model.name) + \(entry.model.age)")
    }
}

@main
struct RxDemoWidget: Widget {
    let kind: String = "RxDemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RxDemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct RxDemoWidget_Previews: PreviewProvider {
    static var previews: some View {
        let item = SimpleModel(name: "李小龙", age: 25)
        RxDemoWidgetEntryView(entry: SimpleEntry(date: Date(), model: item))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
