//
//  Checkers+Results.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 23.11.22.
//

import UIKit
import RxSwift
import RxCocoa

extension Checkers {
    func setupStyle() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = resultsView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        resultsView.addSubview(blurEffectView)
        resultsView.bringSubviewToFront(resultsTableView)
    }

    func addDBButtons() {
        resultsCopy = results
        view.addSubviews([clearAllButton, sortButton])

        clearAllButton.snp.makeConstraints {
            $0.edges.equalTo(newGameBtn)
        }

        sortButton.snp.makeConstraints {
            $0.edges.equalTo(settingsBtn)
        }

        self.clearAllButton.transform = self.clearAllButton.transform.scaledBy(x: 0.001, y: 0.001)
        self.sortButton.transform = self.sortButton.transform.scaledBy(x: 0.001, y: 0.001)

        clearAllButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.clearAllResults()
            })
            .disposed(by: disposeBag)

        sortButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: {
                self.sortResults()
            })
            .disposed(by: disposeBag)
    }

    func sortResults() {
        if results == resultsCopy {
            results.sort(by: {
                $0.gameTime?.convertTimeToInt() ?? 0 < $1.gameTime?.convertTimeToInt() ?? 0
            })
            isResultsOriginal = false
        } else {
            results = resultsCopy
            isResultsOriginal = true
        }

        DispatchQueue.main.async {
            self.resultsTableView.reloadData()
        }
    }

    func clearAllResults() {
        CoreDataManager.shared.clearAllResults {
            results = CoreDataManager.shared.getResults()
            resultsCopy = results
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
    }
}
