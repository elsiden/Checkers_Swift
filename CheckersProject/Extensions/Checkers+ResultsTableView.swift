//
//  Checkers+ResultsTableView.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 01.12.2021.
//

import UIKit
import SnapKit

extension Checkers: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        results = CoreDataManager.shared.getResults()
        resultsTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.identifier)
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as? ResultsTableViewCell
        else { return UITableViewCell() }
        cell.configure(with: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsTableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { action, sourceView, completionHandler in
            CoreDataManager.shared.removeGameFromResults(by: self.results[indexPath.row].gameTime ?? "")
            completionHandler(true)
            DispatchQueue.main.async {
                self.results.remove(at: indexPath.row)
                self.resultsCopy = self.results
                self.resultsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        action.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [action])
    }
}
