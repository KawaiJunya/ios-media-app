//
//  ArticleListViewController.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: UIViewController, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    private lazy var viewModel: ArticleListViewModel = ArticleListViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        // Cellを登録
        tableView.register(
            UINib(nibName: "ArticleTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ArticleTableViewCell"
        )
        
        tableView.dataSource = self
        
        viewModel.reloadData
            .bind(to: reloadData)
            .disposed(by: disposeBag)
        
        // 記事を取得
        viewModel.getArticleList()
        
        
        // 選択されたらWebViewを開く
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let link = self.viewModel.articles[indexPath.row].url
                self.openArticle(link: link)
            })
        .disposed(by: disposeBag)
        
        
        // 下までスクロールしたら更新
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == (self.tableView.numberOfRows(inSection:indexPath.section)-5) {
                    self.viewModel.getArticleList()
                }
            })
            .disposed(by: disposeBag
        )
    }
    
    private func openArticle(link: String){
        let storyboard: UIStoryboard = UIStoryboard(name: "Article", bundle: nil)
        let articleVC = storyboard.instantiateViewController(withIdentifier: "ArticleVC") as? ArticleViewController
        if let article = articleVC {
            article.link = link //値を受け渡す
            present(article, animated: true, completion: nil)
        }
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell

        let article = viewModel.articles[indexPath.row]
        cell.set(article: article)

        return cell
    }
}

extension ArticleListViewController{
    private var reloadData: Binder<Void> {
        return Binder(self) { me, _ in
            me.tableView.reloadData()
        }
    }
}
