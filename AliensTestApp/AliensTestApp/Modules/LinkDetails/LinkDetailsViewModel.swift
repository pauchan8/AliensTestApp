//
//  LinkDetailsViewModel.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import SwiftUI
import Combine
import WebKit

class LinkDetailsViewModel: ObservableObject {
    @Published var readableContent: ObjectState<MercuryContentModel> = .value(nil)
    @Published var htmlContent: String?
    var url: URL? {
        return URL(string: link.url)
    }

    private let link: Link
    private let apiService: LinkDetailsAPIService
    let webViewDelegate: WebViewDelegate
    private var cancellables = Set<AnyCancellable>()

    init(link: Link, apiService: LinkDetailsAPIService, webViewDelegate: WebViewDelegate) {
        self.link = link
        self.apiService = apiService
        self.webViewDelegate = webViewDelegate
    }
    
    func isLoading(for mode: LinkDetailsMode) -> Bool {
        switch mode {
        case .web: return webViewDelegate.loadingState == .loading
        case .reader: return readableContent == .loading
        }
    }
    
    func fetchLink() {
        readableContent = .loading
        apiService.parsedReaderHTML(link.url)?
            .sink { [weak self] error in
                if self?.readableContent == .loading {
                    self?.readableContent = .value(nil)
                }
            } receiveValue: { [weak self] contentModel in
                self?.readableContent = .value(contentModel)
            }
            .store(in: &cancellables)
    }
}
