//
//  HighlightView.swift
//  Diary
//
//  Created by 성재 on 5/12/24.
//

import SwiftUI
import Kingfisher
import Charts
import SwiftUICharts

struct HighlightView: View {
    
    /// coredata
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
    @Environment(\.managedObjectContext) var viewContext
    
    @State var todoarr: [DB_core] = []
    @State var todoemot: [Double] = []
    @State var tododict = Dictionary<Int, [Array<DB_core>.Element]>()
    @State var tododict2 = Dictionary<Int, Int>()
    @State var todoarrfilter_count: Float = 0.0

    @State var todomax: Int = 0
    @State var todosum: Int = 1
    @State var todoran: Int = 0
    
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"

    
    var body: some View {
        NavigationView(content: {
            ScrollView {
                if !todos.isEmpty {
                    VStack {
                        Spacer().frame(height: 32)
                        
                        HStack {
                            Spacer().frame(width: 15)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.white)
                                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 5)

                                VStack {
                                    HStack {
                                        Text("\(formatDate_Month(Date.now))")
                                            .foregroundStyle(.black)
                                            .font(.custom("SUIT-Semibold", size: 20))
//                                        Text("\(Date.now.startOfMonth())")
//                                            .foregroundStyle(.black)
//                                            .font(.custom("SUIT-Semibold", size: 10))
                                        Spacer()
                                    }
                                    .padding()
                                    
                                    Spacer().frame(height: 10)
                                    HStack {
                                        ZStack {
                                            CircularProgressView(progress: CGFloat(todoarrfilter_count/100))
                                            HStack {
                                                Text("\(Int(todoarrfilter_count))%")
                                                    .foregroundStyle(.subpoint)
                                                    .multilineTextAlignment(.leading)
                                                    .font(.custom("SUIT-Bold", size: 20))
                                                    .clipped()

                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding()

                                }
                            }
                            .frame(width: AppConfig.homeWidth/2-25, height: AppConfig.homeWidth/2-30)
                            
                            Spacer().frame(width: 15)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(
                                        AngularGradient(gradient: Gradient(colors: [Color.mainpoint, Color.maingra]),
                                                        center: .bottomLeading,
                                                       angle: .degrees(0 + 45))
                                    )
//                                        .foregroundStyle(.accent)
                                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 5)

                                
                                VStack {
                                    HStack {
                                        Text("Diarys")
                                            .font(.custom("SUIT-Bold", size: 18))
                                            .foregroundStyle(.whitegray)
                                        Spacer()
                                    }
                                    .padding()
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Text("\(todos.count)")
                                            .font(.custom("SUIT-Bold", size: 40))
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                            .frame(width: AppConfig.homeWidth/2-25, height: AppConfig.homeWidth/2-30)

                            
                            Spacer().frame(width: 15)
                        }
                        .frame(width: AppConfig.homeWidth-30, height: AppConfig.homeWidth/2)
                        .padding(.horizontal, 15)
                        
                        Spacer().frame(height: 28)
                        
                        Rectangle().frame(height: 1, alignment: .center)
                            .padding(.leading, 28)
                            .padding(.trailing, 28)
                            .foregroundStyle(.gray5)
                        
                        Spacer().frame(height: 28)
                        
                        ZStack {
//                            RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.white)
//                                .shadow(color: .black.opacity(0.1), radius: 50, x: 0, y: 5)

                            HStack {
                                VStack {
                                    HStack {
                                        Text(todos[todoran].title ?? "")
                                            .lineLimit(1)
                                            .font(.custom("SUIT-Bold", size: 18))
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 5)
                                    
                                    HStack {
                                        Text(todos[todoran].date ?? Date.now, format: .dateTime.day(.twoDigits).month(.twoDigits))
                                            .lineLimit(1)
                                            .font(.custom("NotoSansKR-Regular", size: 14))
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 5)
                                    
                                    
                                    HStack {
                                        Text(todos[todoran].status!)
                                            .lineLimit(3)
                                            .font(.custom("NotoSansKR-Regular", size: 15))
                                            .foregroundColor(.black)
                                            .lineSpacing(7.0)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 5)
                                    
                                    //                                        Spacer()
                                }
                            }
                        }
                        .frame(width: AppConfig.homeWidth-30, height: AppConfig.homeWidth/2)
                        
                        Spacer().frame(height: 28)
                        
                        Rectangle().frame(height: 1, alignment: .center)
                            .padding(.leading, 28)
                            .padding(.trailing, 28)
                            .foregroundStyle(.gray5)
                        
                        Spacer().frame(height: 28)
                        
                        ZStack {
//                            RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.white)
//                                .shadow(color: .black.opacity(0.1), radius: 50, x: 0, y: 5)
                            if !todos[0].image.isEmpty {
                                KFImage.url(todos[0].image.first)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth/2)
                                    .clipped()

                            } else {
                                Text(todos[0].title!)
                                    .foregroundStyle(.black)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                                    .font(.Arita_buriBold_edt)
                                    .frame(width: AppConfig.homeWidth)
                                    .blur(radius: 3)
                                    .clipped()
                            }
                            
                            VStack {
                                LinearGradient(colors: [Color.clear, Color.clear, Color.black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                            }
                            
                            VStack {
                                Spacer()
                                HStack {
                                    Text(todos[0].title!)
                                        .foregroundStyle(.white)
                                        .font(.custom("SUIT-Bold", size: 16))
                                    Spacer()
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                        .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth/2)

                        Spacer().frame(height: 28)
                        
                        Rectangle().frame(height: 1, alignment: .center)
                            .padding(.leading, 28)
                            .padding(.trailing, 28)
                            .foregroundStyle(.gray5)
                        
                        Spacer().frame(height: 44)
                        
                        
                        HStack {
                            Text("Statics")
                                .font(.custom("SUIT-Bold", size: 26))
                                .padding(.leading, 16)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .frame(width: AppConfig.homeWidth)
                        
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.whitegray)
                                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 5)
                                
                                VStack {
                                    HStack(alignment: .top) {
                                        VStack {
                                            Text("Emotions")
                                                .font(.custom("SUIT-Regular", size: 16))
                                            Spacer().frame(height: 5)
                                            HStack {
                                                Text("\(todomax)")
                                                    .font(.custom("SUIT-Bold", size: 40))
                                                Text("/")
                                                    .font(.custom("SUIT-Regular", size: 16))
                                                Text("\(todosum)")
                                                    .font(.custom("SUIT-Regular", size: 16))
                                            }
                                        }
                                        Spacer()
                                        Text("\( Int( Float(todomax) / Float(todosum) * 100) ) %")
                                            .font(.custom("SUIT-Bold", size: 19))
                                            .foregroundStyle(Color.indigo)
                                    }
                                    Spacer().frame(height: 10)
                                    
                                    Chart(tododict.keys.sorted(), id: \.self) { key in
                                        SectorMark(
                                            angle: .value("Count", tododict[key]!.count),
                                            innerRadius: .ratio(0.718),
                                            angularInset: 1.5
                                        )
                                        .cornerRadius(5)
                                        .foregroundStyle(by: .value("Name", Mockdata2.textnames2[key]))
                                    }
                                    .frame(width: AppConfig.homeWidth/2, height: AppConfig.homeWidth/1.5)
                                    
                                }.padding()
                            }
                        }
                        .frame(width: AppConfig.homeWidth-30)
                        .padding(15)
                        
                    }
                    Spacer().frame(height: 80)

                } else {
                    Spacer()
                        .frame(height: 100)
                    Image("emptybox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding()
                    Text("Diary is Empty!")
                        .font(.custom("SUIT-SemiBold", size: 22))
                    Spacer()

                }
            }
            .frame(width: AppConfig.homeWidth)
            .background(.white)
            .navigationTitle("Yours")
        })
        .onAppear {
            if !todos.isEmpty {
                
                todoarr = Array(todos)
                todoran = Int.random(in: 0..<todos.count)
                tododict = Dictionary(grouping: todoarr, by: { Int($0.emotions) })
                tododict2 = dictcount(dict: tododict)
                todomax = tododict2.values.max()!
                todosum = tododict2.values.reduce(0, +)
                
                todoarrfilter_count = arrfilter(array: todoarr)
            }
        }
        .onReceive(todos.publisher.collect(), perform: { objects in
            if !todos.isEmpty {
                todoarr = Array(todos)
                tododict = Dictionary(grouping: todoarr, by: { Int($0.emotions) })
                tododict2 = dictcount(dict: tododict)
                todomax = tododict2.values.max()!
                todosum = tododict2.values.reduce(0, +)
                todoarrfilter_count = arrfilter(array: todoarr)
            }
            
        })
        .edgesIgnoringSafeArea(.all)
    }
    
    private func formatDate_day(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return Int(formatter.string(from: date))!
    }
    
    private func arrfilter(array: [DB_core]) -> Float {
        let cnt = array.filter { $0.date! >= Date.now.startOfMonth() }.count
        let date = formatDate_day(Date.now)

        return round(Float(Float(100 * cnt) / Float(date))*10)/10
    }
    
    private func formatDate_Month(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월"
        return formatter.string(from: date)
    }
    
    private func dictcount(dict: Dictionary<Int, [Array<DB_core>.Element]>) -> Dictionary<Int, Int> {
        var dict2 = Dictionary<Int, Int>()
        
        for key in dict.keys {
            dict2[key] = dict[key]!.count
        }
        
        return dict2
    }
    
//    private func checkIfDateIsWithin(date: Date) -> Int {
//        
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.hour], from: Date.now)
//        let hour = components.hour ?? 0
//        
//        var startDate = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
//        var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
//        
//        if hour < 11 {
//            startDate = Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
//            endDate = Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!)!
//        }
//
//        return calendar.dateComponents([.day], from: date, to: Date()).day!
//    }
    
}
