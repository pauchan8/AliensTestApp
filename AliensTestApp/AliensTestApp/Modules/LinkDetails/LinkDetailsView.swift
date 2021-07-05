//
//  LinkDetailsView.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import SwiftUI
import SafariServices
import WebKit
import Combine

enum LinkDetailsMode: String, Equatable, Identifiable, CaseIterable {
    var id: String { rawValue }
    case web
    case reader
}

struct LinkDetailsView: View {
    @ObservedObject var viewModel: LinkDetailsViewModel
    
    @State private var isWebViewLoading: Bool = false
    @State private var selectedMode: LinkDetailsMode = .web
    @State private var readerHtml: String?
    @State private var attributedTextHeight: CGFloat = 0
    @State private var attributedTextWidth: CGFloat = 0
    
    @ViewBuilder
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                switch selectedMode {
                case .web:
                    if let url = viewModel.url {
                        WebView(url: url, delegate: viewModel.webViewDelegate)
                            .onReceive(viewModel.webViewDelegate.$loadingState) { val in
                                DispatchQueue.main.async {
                                    isWebViewLoading = val == .loading
                                }
                            }
                        if isWebViewLoading {
                            progressView
                        }
                    } else {
                        EmptyView()
                    }
                case .reader:
                    ScrollView {
                        AttributedText(html: $readerHtml, contentHeight: $attributedTextHeight, maxWidth: proxy.size.width * 0.975)
                            .frame(height: attributedTextHeight)
                            .onReceive(viewModel.$readableContent) {
                                if case let .value(content) = $0 {
                                    readerHtml = content?.content
                                }
                            }
                    }
                    if viewModel.readableContent == .loading {
                        progressView
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedMode) {
                    ForEach(LinkDetailsMode.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchLink()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var progressView: some View {
        Rectangle()
            .fill(Color.white)
            .frame(alignment: .center)
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }
}

struct LinkDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        return LinkDetailsView(viewModel: LinkDetailsViewModel(link: LinkFactory.base().first!, apiService: LinkDetailsAPIService(), webViewDelegate: WebViewDelegate()))
    }
}
