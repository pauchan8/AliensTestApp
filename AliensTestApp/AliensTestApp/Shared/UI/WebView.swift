//
//  WebView.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 05.07.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let delegate: WebViewDelegate?
    
    init(url: URL, delegate: WebViewDelegate? = nil) {
        self.url = url
        self.delegate = delegate
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = delegate
        view.configuration.suppressesIncrementalRendering = true
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        delegate?.loadingState = .loading
        uiView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
    }
}

class WebViewDelegate: NSObject, WKNavigationDelegate {
    @Published var loadingState: ObjectState<Bool> = .value(nil)
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingState = .value(true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingState = .value(true)
    }
}
