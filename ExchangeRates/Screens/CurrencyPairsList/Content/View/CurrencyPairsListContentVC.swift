//
//  CurrencyPairsListContentVC.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPairsListContentInput: AnyObject {
    func reload()

    func listContent(_ sender: Any, showAlert message: String)
}

protocol CurrencyPairsListContentOutput: AnyObject {
}

final class CurrencyPairsListContentVC: UIViewController {
    typealias CellDataModel = CurrencyPairsListContentCellDataModel
    typealias ViewModel = CurrencyPairsListContentViewModel
    typealias Delegate = CurrencyPairsListOutput

    private weak var listContainerDelegate: Delegate?

    private var viewModel: ViewModel?

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = viewModel
        table.delegate = viewModel
        table.translatesAutoresizingMaskIntoConstraints = false

        CellDataModel.registerCells(tableView: table)
        return table
    }()

    func setup(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()

        viewModel?.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.willAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel?.willDisappear()
    }
}

extension CurrencyPairsListContentVC {
    private func prepareUI() {
        view.addSubview(tableView)

        let guide = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}

// MARK: - CurrencyPairsListContentInput
extension CurrencyPairsListContentVC: CurrencyPairsListContentInput {

    func reload() {
        tableView.reloadData()
    }

    func listContent(_ sender: Any, showAlert message: String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100))
        toastLabel.backgroundColor = .lightGray
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
