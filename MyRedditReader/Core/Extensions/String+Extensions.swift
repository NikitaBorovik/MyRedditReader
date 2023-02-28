//
//  String+Extensions.swift
//  MyRedditReader
//
//  Created by Нікіта Боровік on 28.02.2023.
//

import Foundation

extension String{
    var formattedURL: URL? {
        return URL(string: self.replacingOccurrences(of: "&amp;", with: "&"))
    }
}
