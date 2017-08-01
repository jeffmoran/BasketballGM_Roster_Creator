//
//  Extensions.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 4/1/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

extension NSImageView {
    private func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
			guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { self.setPlaceholderImage(); return }

            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { self.setPlaceholderImage(); return }

            guard let data = data, error == nil else { self.setPlaceholderImage(); return }

            guard let image = NSImage(data: data) else { self.setPlaceholderImage(); return }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }

    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { setPlaceholderImage(); return }

        downloadedFrom(url: url)
    }

	private func setPlaceholderImage() {
		DispatchQueue.main.async {
			// TODO: Use actual placeholder
			self.image = nil
		}
	}
}
