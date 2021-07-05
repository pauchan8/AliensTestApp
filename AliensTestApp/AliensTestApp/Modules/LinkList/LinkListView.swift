//
//  LinkListView.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import SwiftUI

struct LinkListView: View {
    let viewModel: LinkListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.links) { link in
                NavigationLink(destination: LinkDetailsView(viewModel: viewModel.detailsViewModel(for: link))) {
                    Text(link.name)
                        .padding([.top, .trailing, .bottom], 8)
                        .font(.title3)
                        .lineLimit(2)
                }
            }
            .navigationTitle("Featured")
        }
    }
}

struct LinkListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = LinkListViewModel(links: LinkFactory.base(), apiService: LinkDetailsAPIService())
        return LinkListView(viewModel: model)
    }
}
