//
//  ArticleListViewModel.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleListViewModel{
    private let articleRepository: ArticleListRepository
    private let disposeBag = DisposeBag()

    
    var articles: [Article] { return _articles.value }

    private let _articles = BehaviorRelay<[Article]>(value: [])

    let reloadData: Observable<Void>

    private var page = 1

    init(){
        articleRepository = ArticleListRepository()
        self.reloadData = _articles.map { _ in }
    }
    
    func getArticleList(){
        self.articleRepository.getArticles(page: self.page)
            .subscribe(
                onNext: { response in
                    print(self.page)
                    self.page += 1
                    self._articles.accept(self.articles + response)
                },
                onError: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}
