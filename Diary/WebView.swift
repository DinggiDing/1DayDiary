//
//  WebView.swift
//  Diary
//
//  Created by 성재 on 6/2/24.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView {
            
            //unwrapping
            guard let url = URL(string: self.urlToLoad) else {
                return WKWebView()
            }
            //웹뷰 인스턴스 생성
            let webView = WKWebView()
            
            //웹뷰를 로드한다
            webView.load(URLRequest(url: url))
            return webView
        }
        
    //업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}

