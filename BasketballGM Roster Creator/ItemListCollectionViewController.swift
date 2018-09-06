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

	var placeholderString: String {
		switch self {
		case .players: return "Search Players"
		case .teams: return "Search Teams"
		case .draftPicks: return "Search Draft Picks"
		}
	}

	var collectionViewItemID: String {
		switch self {
		case .players: return "PlayerCollectionViewItem"
		case .teams: return "TeamCollectionViewItem"
		case .draftPicks: return "DraftPickCollectionViewItem"
		}
	}
}

class ItemListCollectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, NSSearchFieldDelegate {

	private var contentMode: ContentMode = .players {
		didSet {
			searchField.placeholderString = contentMode.placeholderString

			switch contentMode {
			case .players:
				searchField.stringValue = playersSearchString
			case .teams:
				searchField.stringValue = teamsSearchString
			case .draftPicks:
				searchField.stringValue = draftPicksSearchString
			}
		}
	}

	private var window: MainWindowController? {
		return view.window?.windowController as? MainWindowController
	}

	private var filteredPlayers: [Player]?
	private var filteredTeams: [Team]?
	private var filteredDraftPicks: [DraftPick]?

	private var playersSearchString: String = ""
	private var teamsSearchString: String = ""
	private var draftPicksSearchString: String = ""

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
		flowLayout.itemSize = NSSize(width: 350.0, height: 110.0)
		flowLayout.sectionInset = NSEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

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

	func initialImport() {
		let when = DispatchTime.now() + 0.1

		DispatchQueue.main.asyncAfter(deadline: when) {
			self.filteredPlayers = API.shared.getAllPlayers()
			self.filteredTeams = API.shared.getAllTeams(includingFakeTeams: false)
			self.filteredDraftPicks = API.shared.getAllDraftPicks()

			self.collectionView.reloadData()
		}
	}

	func refreshCollectionViewWith(_ contentMode: ContentMode) {
		self.contentMode = contentMode

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

		let identifier = NSUserInterfaceItemIdentifier(rawValue: contentMode.collectionViewItemID)

		switch contentMode {
		case .players:
			guard let collectionViewItem = collectionView.makeItem(withIdentifier: identifier, for: indexPath) as? PlayerCollectionViewItem else { return item }

			if let player = filteredPlayers?[indexPath.item] {
				collectionViewItem.player = player
			}

			item = collectionViewItem
		case .teams:
			guard let collectionViewItem = collectionView.makeItem(withIdentifier: identifier, for: indexPath) as? TeamCollectionViewItem else { return item }

			if let team = filteredTeams?[indexPath.item] {
				collectionViewItem.team = team
			}

			item = collectionViewItem
		case .draftPicks:
			guard let collectionViewItem = collectionView.makeItem(withIdentifier: identifier, for: indexPath) as? DraftPickCollectionViewItem else { return item }

			if let draftPick = filteredDraftPicks?[indexPath.item] {
				collectionViewItem.draftPick = draftPick
			}

			item = collectionViewItem
		}

		return item
	}

	// MARK: - NSCollectionViewDelegate

	var playersDetailsViewController: PlayerDetailViewController? {
		if let splitViewController = parent as? NSSplitViewController {
			return splitViewController.childViewControllers[2] as? PlayerDetailViewController
		} else {
			return nil
		}
	}

	var teamDetailViewController: TeamDetailViewController? {
		if let splitViewController = parent as? NSSplitViewController {
			return splitViewController.childViewControllers[2] as? TeamDetailViewController
		} else {
			return nil
		}
	}

	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		switch contentMode {
		case .players:
			if let indexPathItem = indexPaths.first?.item {
				playersDetailsViewController?.player = filteredPlayers?[indexPathItem]
			}
		case .teams:
			if let indexPathItem = indexPaths.first?.item {
				teamDetailViewController?.team = filteredTeams?[indexPathItem]
			}
		case .draftPicks:
			return
		}
	}

	func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
		playersDetailsViewController?.player = nil
	}

	// MARK: - NSSearchFieldDelegate

	override func controlTextDidChange(_ obj: Notification) {
		if let searchField = obj.object as? NSSearchField {
			let searchString = searchField.stringValue

			switch contentMode {
			case .players:
				playersSearchString = searchString

				filteredPlayers = API.shared.getAllPlayers()?.filter { $0.fullName.uppercased().contains(searchString.uppercased()) || $0.team?.fullTeamName.uppercased().contains(searchString.uppercased()) ?? false }

				if searchString.isEmpty { filteredPlayers = API.shared.getAllPlayers() }
			case .teams:
				teamsSearchString = searchString

				filteredTeams = API.shared.getAllTeams(includingFakeTeams: false)?.filter { $0.fullTeamName.uppercased().contains(searchString.uppercased()) }

				if searchString.isEmpty { filteredTeams = API.shared.getAllTeams(includingFakeTeams: false) }
			case .draftPicks:
				draftPicksSearchString = searchString

				filteredDraftPicks = API.shared.getAllDraftPicks()?.filter { $0.originalTeam.fullTeamName.uppercased().contains(searchString.uppercased()) || $0.destinationTeam.fullTeamName.uppercased().contains(searchString.uppercased()) }

				if searchString.isEmpty { filteredDraftPicks = API.shared.getAllDraftPicks() }
			}

			collectionView.reloadData()
		}
	}

}
