//
//  KeychainModel.swift
//  Virtbase
//
//  Created by Karl Ehrlich on 12.02.26.
//

import Foundation
import Security

enum KeychainError: LocalizedError {
    
    case unknown
    // something happened
    // that shouldnt have happened
    // TODO: make verbose
    
    case corrupt
    // data fucked for some reason
    // probably wont ever happen
    
    // read was called before
    // anything was written to keychain
    // useful for checking session
    case empty
}

final class KeychainModel {

    private static let service = "com.virtbase.Virtbase"
    private static let account = "com.virtbase.Session"

    // base query used by all three operations
    // identifies the keychain item by service + account
    private static var baseQuery: [CFString: Any] {[
        kSecClass:       kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ]}

    static func write(token: String) throws {
        // encode token to utf8 before storing
        guard let data = token.data(using: .utf8) else { throw KeychainError.corrupt }

        // extend base query with the data and access policy
        // only accessible when device is unlocked, non-migratable
        var query = baseQuery
        query[kSecValueData] = data
        query[kSecAttrAccessible] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            // item already exists, update it instead
            let update: [CFString: Any] = [kSecValueData: data]
            guard SecItemUpdate(baseQuery as CFDictionary, update as CFDictionary) == errSecSuccess else {
                throw KeychainError.unknown
            }
        } else if status != errSecSuccess {
            throw KeychainError.unknown
        }
    }

    static func read() throws -> String {
        // ask keychain to return the raw data for our item
        var query = baseQuery
        query[kSecReturnData] = true
        query[kSecMatchLimit] = kSecMatchLimitOne

        var result: AnyObject?
        switch SecItemCopyMatching(query as CFDictionary, &result) {
        case errSecSuccess:
            // decode the returned data back to a string
            guard let data = result as? Data, let token = String(data: data, encoding: .utf8)
            else { throw KeychainError.corrupt }
            return token
        case errSecItemNotFound:
            // nothing stored yet, caller can treat this as "not logged in"
            throw KeychainError.empty
        default:
            throw KeychainError.unknown
        }
    }

    static func delete() throws {
        // used on logout to clear the stored session token
        // not found is fine — item was already gone
        let status = SecItemDelete(baseQuery as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknown
        }
    }
}
