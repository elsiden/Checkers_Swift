//
//  String+Extensions.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 23.11.22.
//


extension String {
    func convertTimeToInt() -> Int {
        let components = self.components(separatedBy: [" ", ":"]).compactMap { Int($0) }
        return components[0] * 60 + components[1]
    }
}
