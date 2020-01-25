//
//  ArticleListViewModel.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import Foundation
import RxSwift

class ArticleListViewModel{
    
    let articleRepository: ArticleListRepository
    private let disposeBag = DisposeBag()
    
    var articleList: [Article]
    private let _articleList = BehaviorRelay<[Article]>(value: [])
    
    // Observables
    let reloadData: Observable<Void>
    
    init(){
        articleRepository = ArticleListRepository()
        self.reloadData = _articleList.map { _ in }
    }
    
    func getArticleList(){
        self.articleRepository.getArticles()
            .subscribe(
                onNext: { response in
                    print(response)
                },
                onError: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
    
}
