//
//  DashboardViewController.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class DashboardViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    var viewmodel: DashboardViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        addRightBarButton()
        viewmodel = container.resolve(DashboardViewModel.self)
        tableView.delegate = self
        tableView.dataSource = self
        viewmodel.fetch().start({ (signal) in
            self.tableView.reloadData()
        })
    }
    func addRightBarButton() {
        let button = UIButton(type: .system)
        button.setTitle("Sort", for: .normal)
        let interaction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(interaction)
        let sortBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems = [sortBarButton]
    }
    func addActionsInContextMenu() -> [UIAction] {
        let limitAction = UIAction(title: "Limit to 100") { (action) in
            self.viewmodel.state.value = .hundred
            self.tableView.reloadData()
        }
        let reverceAction = UIAction(title: "Reverse") { (action) in
            self.viewmodel.state.value = .reverse
            self.tableView.reloadData()
        }
        return [limitAction, reverceAction]
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewmodel.getTextForRow(index: indexPath.row)
        return cell
    }
}

extension DashboardViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let children: [UIMenuElement] = self.addActionsInContextMenu()
            return UIMenu(title: "Sort", children: children)
        })
    }
}
