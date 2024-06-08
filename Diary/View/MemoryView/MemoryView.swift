//
//  MemoryView.swift
//  Diary
//
//  Created by 성재 on 3/28/24.
//

import SwiftUI
import Kingfisher

struct MemoryView: View {
    
//    @State private var filterScope: FilterScope = FilterScope(filter: Date.now, filter_on: false)
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) private var todos: FetchedResults<DB_core>

    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
            
            NavigationStack {
                Spacer().frame(height: 8)
                
                ScrollView {
                    Spacer().frame(height: 5)
                    
                    LazyVGrid(columns: columns,  spacing: 0) {
                        
                        ForEach(group(todos, formatDate_Year_integer(_:)), id: \.self) { (section: [DB_core]) in
                            
                            NavigationLink(destination: {
                                
                                MemoryMonthView(section, titlestring: formatDate_Year(section[0].date!))
                                
                            }, label: {
                                //VStack으로 도형추가
                                ZStack(alignment: .center) {
                                    if !section[0].image.isEmpty {
                                        KFImage.url(section[0].image.first)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth3)
                                            .clipped()
                                    } else {
                                        Text(section[0].title!)
                                            .foregroundStyle(.black)
                                            .lineLimit(3)
                                            .multilineTextAlignment(.leading)
                                            .font(.Arita_buriBold_edt)
                                            .frame(width: AppConfig.homeWidth/2-1)
                                            .blur(radius: 3)
                                            .clipped()
                                    }
                                    
                                    VStack {
                                        LinearGradient(colors: [Color.clear, Color.clear, Color.black], startPoint: .top, endPoint: .bottom)
                                    }
                                    
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Text(formatDate_Year(section[0].date!))
                                                .foregroundStyle(.white)
                                                .font(.custom("SUIT-Bold", size: 16))
                                            Spacer()
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                }.frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth3)
                            
                            })
                        }
                    }
                                        
                    Spacer().frame(height: 65)
                }
                .navigationTitle("Memory")
            }
        
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY / MM / dd"
        return formatter.string(from: date)
    }
    
    private func formatDate_Month(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월"
        return formatter.string(from: date)
    }
    
    private func formatDate_Year(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter.string(from: date)
    }
    
    private func formatDate_Year_integer(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return Int(formatter.string(from: date)) ?? 0
    }
    
    func group(_ result : FetchedResults<DB_core>, _ function : (Date) -> Int) -> [[DB_core]] {
//        let sorted = result.sorted { $0.date! < $1.date! }

        return Dictionary(grouping: result) { (element : DB_core)  in
            function(element.date! as Date)
        }.values.map{ $0 }
    }
        
}

extension Date {
    // This Month Start
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
//    func startOfMonth() -> Date {
//        let interval = Calendar.current.dateInterval(of: .month, for: self)
//        return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
//    }
    
    func endOfMonth() -> Date {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
//    func endOfMonth() -> Date {
//        let interval = Calendar.current.dateInterval(of: .month, for: self)
//        return interval!.end
//    }
    
    // This Year Start
    func startOfYeear() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
//    func startOfYeear() -> Date {
//        let interval = Calendar.current.dateInterval(of: .year, for: self)
//        return (interval?.start.toLocalTime())!
//    }
//    
    func endOfYear() -> Date {
        let interval = Calendar.current.dateInterval(of: .year, for: self)
        return interval!.end
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone    = TimeZone.current
        let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
