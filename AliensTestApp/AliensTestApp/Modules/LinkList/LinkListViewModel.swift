//
//  LinkListViewModel.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Combine

class LinkListViewModel: ObservableObject {
    let links: [Link]
    private let apiService: LinkDetailsAPIService
    
    init(links: [Link], apiService: LinkDetailsAPIService) {
        self.links = links
        self.apiService = apiService
    }
    
    func detailsViewModel(for link: Link) -> LinkDetailsViewModel {
        return LinkDetailsViewModel(link: link, apiService: apiService, webViewDelegate: WebViewDelegate())
    }
}
