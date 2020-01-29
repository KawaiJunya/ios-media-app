//
//  ArticleListViewController.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit
import RxSwift

class ArticleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var viewModel: ArticleListViewModel = ArticleListViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticleList()
        viewModel.articleList.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, model, cell in
           cell.textLabel?.text = "\(model.title)"
        }.disposed(by: disposeBag)
    }
}
