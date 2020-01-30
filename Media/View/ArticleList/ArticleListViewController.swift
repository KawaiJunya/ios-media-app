//
//  ArticleListViewController.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit
import RxSwift

class ArticleListViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    private lazy var viewModel: ArticleListViewModel = ArticleListViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cellを登録
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        // 記事を取得
        viewModel.getArticleList()
        
        // 取得結果でリストを更新
        viewModel.articleList.asObservable().bind(
            to: tableView.rx.items(
                cellIdentifier: "ArticleTableViewCell",
                cellType:       ArticleTableViewCell.self
            )
        ) { row, model, cell in
            cell.title.text      = model.title
            cell.author.text     = model.user.name
            cell.thumbnail.image = UIImage(url: model.user.profile_image_url)
        }.disposed(by: disposeBag)
        
        // 選択されたらWebViewを開く
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let link = self.viewModel.articleList.value[indexPath.row].url
                self.openArticle(link: link)
            })
        .disposed(by: disposeBag)
        
        // 下までスクロールしたら更新
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == (self.tableView.numberOfRows(inSection:indexPath.section)-1) {
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
