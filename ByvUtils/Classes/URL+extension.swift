//
//  URL.swift
//  Pods
//
//  Created by Adrian Apodaca on 9/11/16.
//
//

import Foundation

// MARK: - Localization

public extension URL {
    func getQueryItemValueForKey(_ key: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        guard let queryItems = components.queryItems else { return nil }
        return queryItems.filter {
            $0.name == key
            }.first?.value
    }
}
