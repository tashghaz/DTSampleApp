//
//  ApolloService.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import Foundation
import Apollo

final class ApolloService {
    static let shared = ApolloService()

    private(set) lazy var client: ApolloClient = {
        // Load credentials from secure storage
        let credentials = KeychainService.loadCredentials()

        // Default to mock endpoint if no credentials exist
        let url = URL(string: credentials?.apiURL ?? "https://mock.api/graphql")!

        // Setup Apollo components
        let store = ApolloStore()
        let transport = RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: store),
            endpointURL: url,
            additionalHeaders: [
                "Authorization": credentials?.accessToken ?? ""
            ]
        )

        return ApolloClient(networkTransport: transport, store: store)
    }()
}
