//
//  ItemListCollectionViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class ItemListCollectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {

    private lazy var collectionView: NSCollectionView = {
        let collectionView = NSCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isSelectable = true
        collectionView.delegate = self
        collectionView.dataSource = self

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 20.0, bottom: 0.0, right: 20.0)

        collectionView.collectionViewLayout = flowLayout

        return collectionView
    }()

    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = self.collectionView

        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        view.addSubview(scrollView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }

    // MARK: - NSCollectionViewDataSource

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "PlayerCollectionViewItem", for: indexPath)

        guard let collectionViewItem = item as? PlayerCollectionViewItem else { return item }

        print("Returning item for item at index \(indexPath.item)")
        
        return collectionViewItem
    }

    // MARK: - NSCollectionViewDelegate

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print("Selected", indexPaths)
    }

    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        print("Deselected", indexPaths)
    }
}
