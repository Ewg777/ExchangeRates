//
//  CurrencyPickerVC.swift
//  ExchangeRates
//
//  Created by Evgeniy Garkusha on 20/04/2017.
//  Copyright © 2019 Just For Fun. All rights reserved.
//

import UIKit

protocol CurrencyPickerInput: AnyObject {
    func reloadTable()
}

protocol CurrencyPickerOutput: AnyObject {
    func currencyPicker(_ sender: Any, didSelectCurrency currency: CurrencyModel)
}

final class CurrencyPickerVC: UIViewController {
    typealias DataManager = CurrencyPickerDataManagerProtocol
    typealias CellDataModel = CurrencyPickerCellDataModel
    typealias ViewModel = CurrencyPickerViewModel
    
    private var viewModel: ViewModel?
    private var disabledCurrencyFrom: CurrencyModel?

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = viewModel
        table.delegate = viewModel
        table.translatesAutoresizingMaskIntoConstraints = false

        CellDataModel.registerCells(tableView: table)
        return table
    }()
    // MARK: -
    
    init(disabledCurrencyFrom: CurrencyModel?) {
        self.disabledCurrencyFrom = disabledCurrencyFrom

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()

        viewModel?.didLoad()
    }
}

extension CurrencyPickerVC {

    private func prepareUI() {
        view.addSubview(tableView)

        let guide = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
}

// MARK: - CurrencyPickerInput
extension CurrencyPickerVC: CurrencyPickerInput {

    func reloadTable() {
        tableView.reloadData()
    }
}
