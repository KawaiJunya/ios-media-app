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
        
        // cellの高さ設定
        tableView.rowHeight = 100
        
        // Cellを登録
        tableView.register(
            UINib(nibName: "ArticleTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ArticleTableViewCell"
        )
        
        // tableViewに表示するデータソースの設定
        tableView.dataSource = self
        
        // データ取得後の更新処理を発火
        viewModel.reloadData
            .bind(to: reloadData)
            .disposed(by: disposeBag)
        
        // 記事を取得
        viewModel.getArticleList()
        
        
        // 記事が選択されたらWebViewを開く
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let link = self.viewModel.articles[indexPath.row].url
                self.openArticle(link: link)
            })
        .disposed(by: disposeBag)
        
        
        // (最下部-10)番目が画面に表示されたら更新
        tableView.rx.willDisplayCell
            .subscribe(onNext: { cell, indexPath in
                if indexPath.row == (self.tableView.numberOfRows(inSection:indexPath.section)-10) {
                    self.viewModel.getArticleList()
                }
            })
            .disposed(by: disposeBag
        )
    }
    
    // ArticleViewControllerに記事のリンクを渡す
    private func openArticle(link: String){
        let storyboard: UIStoryboard = UIStoryboard(name: "Article", bundle: nil)
        let articleVC = storyboard.instantiateViewController(withIdentifier: "ArticleVC") as? ArticleViewController
        if let article = articleVC {
            article.link = link //値を受け渡す
            present(article, animated: true, completion: nil)
        }
    }
}

// tableViewにデータをセットするための設定
extension ArticleListViewController: UITableViewDataSource {
    // データ数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    // 記事のデータをセルに反映
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell

        let article = viewModel.articles[indexPath.row]
        cell.set(article: article)

        return cell
    }
}

// データ取得後にテーブルをリロード
extension ArticleListViewController{
    private var reloadData: Binder<Void> {
        return Binder(self) { me, _ in
            me.tableView.reloadData()
        }
    }
}
