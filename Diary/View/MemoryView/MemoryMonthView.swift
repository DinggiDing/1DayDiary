//
//  MemoryMonthView.swift
//  Diary
//
//  Created by 성재 on 5/2/24.
//

import SwiftUI
import Kingfisher
import OrderedCollections

struct MemoryMonthView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.locale) var locale: Locale

    
    var titlestring: String
    var db : [DB_core]
    var dict = OrderedDictionary<String, [Array<DB_core>.Element]>()
    
    let columns = [
        GridItem(.flexible()),
    ]

    init(_ db: [DB_core], titlestring: String) {
        self.db = db
        self.titlestring = titlestring
        dict = OrderedDictionary(grouping: db, by: { Date().formatDate($0.date!, using: .month) })
        
    }
    
    var groupKey : [String] {
        dict.map({$0.key})
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                
                Spacer().frame(height: 5)
                
                LazyVGrid(columns: columns,  spacing: 0) {
                    ForEach(groupKey, id: \.self) { index in
                        
                        NavigationLink(destination: {
                            
                            MemoryDayView(dict[index]!, titlestring: index)
                            
                        }, label: {
                            //VStack으로 도형추가
                            ZStack(alignment: .center) {
                                if !dict[index]![0].image.isEmpty {
                                    KFImage.url(dict[index]![0].image.first)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth3)
                                        .clipped()
                                } else {
                                    Text(dict[index]![0].title!)
                                        .foregroundStyle(.black)
                                        .lineLimit(3)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.Arita_buriBold_edt(locale: locale))
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
                                        Text("\(index)")
                                            .foregroundStyle(.white)
                                            .font(.custom("SUIT-Bold", size: 16))
                                        Spacer()
                                        Spacer()
                                    }
                                }
                                .padding()
                            }
                            .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth3)
                        })
                    }
                }
                
                Spacer().frame(height: 65)
            }
        }
        .navigationTitle("\(titlestring)")
        .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                  .onChanged { value in // onChanged better than onEnded for this case
                    guard value.startLocation.x < 20, // starting from left edge
                          value.translation.width > 60 else { // swiping right
                    return
                  }
                dismiss()
              }
            )

    }
}


