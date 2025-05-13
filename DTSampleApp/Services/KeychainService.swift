//
//  KeychainService.swift
//  DTSampleApp
//
//  Created by Artashes Ghazaryan on 5/9/25.
//

import Foundation
import Security

final class KeychainService {
    static let apiKey = "com.digitaltwin.credentials"

    static func saveCredentials(_ credentials: Credentials) {
        guard let credentialsData = try? JSONEncoder().encode(credentials) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: apiKey,
            kSecValueData as String: credentialsData
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    static func loadCredentials() -> Credentials? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: apiKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return try? JSONDecoder().decode(Credentials.self, from: data)
        }
        return nil
    }

    static func deleteCredentials() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: apiKey
        ]
        SecItemDelete(query as CFDictionary)
    }
}
