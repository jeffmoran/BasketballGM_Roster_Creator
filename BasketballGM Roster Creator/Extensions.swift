//
//  Extensions.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Foundation
import Cocoa

extension NSImageView {
    private func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { return }

            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { return }

            guard let data = data, error == nil else { return }

            guard let image = NSImage(data: data) else { return }

            DispatchQueue.main.async() { _ in
                self.image = image
            }
            }.resume()
    }

    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else {
            //TODO: If returning, set placeholder image instead
            return
        }
        
        downloadedFrom(url: url)
    }
}
