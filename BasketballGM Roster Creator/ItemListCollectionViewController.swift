//
//  ItemListCollectionViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeff Moran on 3/27/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

enum ContentMode {
	case players, teams, draftPicks
}

class ItemListCollectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, NSSearchFieldDelegate {

	private var contentMode: ContentMode = .players

	private var window: MainWindowController? {
		return view.window?.windowController as? MainWindowController
	}

	private var filteredPlayers: [Player]?
	private var filteredTeams: [Team]?
	private var filteredDraftPicks: [DraftPick]?

	private lazy var searchField: NSSearchField = {
		let searchField = NSSearchField()
		searchField.translatesAutoresizingMaskIntoConstraints = false
		searchField.centersPlaceholder = false
		searchField.delegate = self
		searchField.sendsSearchStringImmediately = true

		return searchField
	}()

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
		view.addSubview(searchField)
		view.addSubview(scrollView)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			view.widthAnchor.constraint(greaterThanOrEqualToConstant: 600),

			searchField.topAnchor.constraint(equalTo: view.topAnchor),
			searchField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
			searchField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
			searchField.heightAnchor.constraint(equalToConstant: 50),

			scrollView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}

	func refreshCollectionViewWith(_ contentMode: ContentMode) {
		self.contentMode = contentMode

		searchField.placeholderString = contentMode == .players ? "Players" : "Teams"
		searchField.stringValue = ""

		filteredPlayers = API.shared.getAllPlayers()
		filteredTeams = API.shared.getAllTeams()
		filteredDraftPicks = API.shared.getAllDraftPicks()

		collectionView.reloadData()
	}

	// MARK: - NSCollectionViewDataSource

	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		switch contentMode {
		case .players:
			return filteredPlayers?.count ?? 0
		case .teams:
			return filteredTeams?.count ?? 0
		case .draftPicks:
			return filteredDraftPicks?.count ?? 0
		}
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		var item = NSCollectionViewItem()

		switch contentMode {
		case .players:
			item = collectionView.makeItem(withIdentifier: "PlayerCollectionViewItem", for: indexPath)

			guard let collectionViewItem = item as? PlayerCollectionViewItem else { return item }

			if let player = filteredPlayers?[indexPath.item] {
				collectionViewItem.player = player
			}

			return collectionViewItem
		case .teams:
			item = collectionView.makeItem(withIdentifier: "TeamCollectionViewItem", for: indexPath)

			guard let collectionViewItem = item as? TeamCollectionViewItem else { return item }

			if let team = filteredTeams?[indexPath.item] {
				collectionViewItem.team = team
			}

			return collectionViewItem
		case .draftPicks:
			item = collectionView.makeItem(withIdentifier: "DraftPickCollectionViewItem", for: indexPath)

			guard let collectionViewItem = item as? DraftPickCollectionViewItem else { return item }

			if let draftPick = filteredDraftPicks?[indexPath.item] {
				collectionViewItem.draftPick = draftPick
			}

			return collectionViewItem
		}
	}

	// MARK: - NSCollectionViewDelegate

	var playersDetailsViewController: PlayerDetailViewController? {
		if let splitViewController = parent as? NSSplitViewController {
			return splitViewController.childViewControllers[2] as? PlayerDetailViewController
		} else {
			return nil
		}
	}

	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		collectionView.deselectItems(at: indexPaths)

		switch contentMode {
		case .players:
			if let indexPathItem = indexPaths.first?.item {
				playersDetailsViewController?.player = filteredPlayers?[indexPathItem]
			}
		case .teams:
			return
		case .draftPicks:
			return
		}

	}

	func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
		print("Deselected", indexPaths)
	}

	// MARK: - NSSearchFieldDelegate

	override func controlTextDidChange(_ obj: Notification) {
		if obj.object as? NSSearchField == searchField {
			let searchString = self.searchField.stringValue

			filteredPlayers = API.shared.getAllPlayers()?.filter { $0.name.uppercased().contains(searchString.uppercased()) }

			filteredTeams = API.shared.getAllTeams()?.filter { $0.region.uppercased().contains(searchString.uppercased()) || $0.name.uppercased().contains(searchString.uppercased()) }

			if searchString.isEmpty {
				filteredPlayers = API.shared.getAllPlayers()
				filteredTeams = API.shared.getAllTeams()
			}

			collectionView.reloadData()
		}
	}

}
