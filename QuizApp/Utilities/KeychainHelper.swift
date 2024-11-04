//
//  KeychainHelper.swift
//  QuizApp
//
//  Created by Ana Oganesiani on 03.11.24.
//

import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}

    // ფუნქცია პაროლის შესანახად
    func savePassword(_ password: String, for account: String) {
        guard let data = password.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    // ფუნქცია პაროლის წასაკითხად
    func getPassword(for account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
