//
//  TeamDetailViewController.swift
//  BasketballGM Roster Creator
//
//  Created by Jeffrey Moran on 8/3/17.
//  Copyright © 2017 Jeff Moran. All rights reserved.
//

import Cocoa

class TeamDetailViewController: NSViewController {
	var team: Team? {
		didSet {
			teamDetailView.team = team
		}
	}

	private lazy var scrollView: NSScrollView = {
		let scrollView = NSScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.documentView = self.teamDetailView

		return scrollView
	}()

	private lazy var teamDetailView: TeamDetailView = {
		let view = TeamDetailView()
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		addSubviews()
		setUpConstraints()
	}

	// MARK: - Private

	private func addSubviews() {
		view.addSubview(scrollView)
	}

	private func setUpConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			teamDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			teamDetailView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
			teamDetailView.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
			])
	}
}
