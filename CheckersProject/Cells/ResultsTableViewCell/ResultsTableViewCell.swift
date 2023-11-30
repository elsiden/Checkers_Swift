//
//  ResultsTableViewCell.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 18.11.22.
//

import UIKit
import SnapKit

final class ResultsTableViewCell: UITableViewCell {
    // MARK: - UI Properties
    private let border: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()

    private let firstName: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.font = UIFont(name: "Chalkduster", size: 15)
        return label
    }()

    private let secondName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkduster", size: 15)
        return label
    }()

    private let gameTime: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkduster", size: 15)
        return label
    }()

    private let gameDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkduster", size: 15)
        return label
    }()

    // MARK: - Properties
    static let identifier = "ResultsTableViewCell"

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(border)
        border.addSubviews([firstName, secondName, gameTime, gameDate])
        setupConstraints()
        border.layer.cornerRadius = 20
        layer.cornerRadius = 20
        border.layer.borderColor = UIColor.white.cgColor
        border.layer.borderWidth = 1
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configure(with viewModel: Results_m) {

        gameTime.text = "Game time: \(viewModel.gameTime ?? "")"
        gameDate.text = "Game date: \(viewModel.gameDate ?? "")"

        if viewModel.winner != viewModel.player1 {
            firstName.text = "Winner: \(viewModel.player2 ?? "")"
            secondName.text = "Loser: \(viewModel.player1 ?? "")"
        } else {
            firstName.text = "Winner: \(viewModel.player1 ?? "")"
            secondName.text = "Loser: \(viewModel.player2 ?? "")"
        }

        firstName.textColor = .green
        secondName.textColor = .red
    }

    func setupConstraints() {
        border.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        firstName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(15)
        }

        secondName.snp.makeConstraints {
            $0.top.equalTo(firstName.snp.bottom)
            $0.leading.equalTo(firstName)
        }

        gameTime.snp.makeConstraints {
            $0.top.equalTo(secondName.snp.bottom)
            $0.leading.equalTo(secondName)
        }

        gameDate.snp.makeConstraints {
            $0.top.equalTo(gameTime.snp.bottom)
            $0.leading.equalTo(gameTime)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        firstName.text = nil
        secondName.text = nil
        gameTime.text = nil
        gameDate.text = nil
    }
}
