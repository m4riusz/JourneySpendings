//
//  FontLoader.swift
//  Core
//
//  Created by Mariusz Sut on 18/09/2021.
//
import Foundation
import CoreGraphics
import CoreText

enum FontLoaderError: Error {
    case fontFileNotFound
    case fontUnreadable
    case fontRegistrationFailed
}

final public class FontLoader {

    private struct Constants {
        static let fontExtension = ".ttf"
    }

    public init() { /*Nop*/ }

    public func load() throws {
        let bundle = Bundle(for: Self.self)
        try FontName.allCases.forEach { try loadCustomFont(bundle: bundle, name: $0.string) }
    }

    private func loadCustomFont(bundle: Bundle, name: String) throws {
        guard let fontURL = bundle.url(forResource: name, withExtension: Constants.fontExtension) else {
            throw FontLoaderError.fontFileNotFound
        }
        guard let provider = CGDataProvider(url: fontURL as CFURL), let font = CGFont(provider) else {
            throw FontLoaderError.fontUnreadable
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        guard error == nil else {
            throw FontLoaderError.fontRegistrationFailed
        }
    }
}
