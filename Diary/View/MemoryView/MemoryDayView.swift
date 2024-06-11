//
//  MemoryDayView.swift
//  Diary
//
//  Created by 성재 on 5/2/24.
//

import SwiftUI
import Kingfisher

struct MemoryDayView: View {
    
    @Environment(\.dismiss) var dismiss

    
    var titlestring: String
    var db : [DB_core]
    
    
    let columns = [
        GridItem(.flexible()),
    ]
    
    init(_ db: [DB_core], titlestring: String) {
        self.db = db
        self.titlestring = titlestring
    }

    
    var body: some View {
        ScrollView {
            
            Spacer().frame(height: 5)
            
            LazyVGrid(columns: columns,  spacing: 0) {
                ForEach(db, id: \.self) { index in
                    
                    NavigationLink(destination: {
                        MemoryDetailView(db: index)
                    }, label: {
                        //VStack으로 도형추가
                        ZStack(alignment: .center) {
                            if !index.image.isEmpty {
                                KFImage.url(index.image.first)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: AppConfig.homeWidth, height: AppConfig.homeWidth3)
                                    .clipped()
                            } else {
                                Text(index.title!)
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
                                    Text(Date().formatDate(index.date!, using: .month_day))
                                        .foregroundStyle(.white)
                                        .font(.custom("SUIT-Regular", size: 15))
                                    Text("·")
                                        .foregroundStyle(.white)
                                        .font(.custom("SUIT-Bold", size: 16))
                                        .padding(.leading, 4)
                                        .padding(.trailing, 4)
                                    Text(index.title!)
                                        .foregroundStyle(.white)
                                        .font(.custom("SUIT-Regular", size: 15))
                                    Spacer()
                                    Spacer()
//                                    Spacer()
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
