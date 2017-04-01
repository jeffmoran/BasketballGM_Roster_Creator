//
//  ItemListCollectionViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

enum ContentMode {
    case players, teams
}

class ItemListCollectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {

    var contentMode: ContentMode = .players

    private var window: MainWindowController? {
        return view.window?.windowController as? MainWindowController
    }

    private lazy var collectionView: NSCollectionView = {
        let collectionView = NSCollectionView()
        collectionView.isSelectable = true
        collectionView.delegate = self
        collectionView.dataSource = self

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 280.0, height: 130.0)
        flowLayout.sectionInset = EdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

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
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 600),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    func refreshCollectionViewWith(_ contentMode: ContentMode) {
        self.contentMode = contentMode
        collectionView.reloadData()
    }

    // MARK: - NSCollectionViewDataSource

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        switch contentMode {
        case .players:
            return API.shared.getNumberOfPlayers()
        case .teams:
            return API.shared.getNumberOfTeams()
        }
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        var item = NSCollectionViewItem()

        switch contentMode {
        case .players:
            item = collectionView.makeItem(withIdentifier: "PlayerCollectionViewItem", for: indexPath)

            guard let collectionViewItem = item as? PlayerCollectionViewItem else { return item }

            if let player = API.shared.getPlayerAt(indexPath.item) {
                collectionViewItem.player = player
            }

            return collectionViewItem

        case .teams:
            item = collectionView.makeItem(withIdentifier: "TeamCollectionViewItem", for: indexPath)

            guard let collectionViewItem = item as? TeamCollectionViewItem else { return item }

            if let team = API.shared.getTeamAt(indexPath.item) {
                collectionViewItem.team = team
            }

            return collectionViewItem
        }
    }

    // MARK: - NSCollectionViewDelegate

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print("Selected", indexPaths)
        collectionView.deselectItems(at: indexPaths)
    }

    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        print("Deselected", indexPaths)
    }
}
