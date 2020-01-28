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
    
    private let disposeBag = DisposeBag()
    let articleRepository: ArticleListRepository
    let articleList = BehaviorRelay<[Article]>(value: [])
    
    init(){
        articleRepository = ArticleListRepository()
    }
    
    func getArticleList(){
        self.articleRepository.getArticles()
            .subscribe(
                onNext: { response in
                    self.articleList.accept(response)
                },
                onError: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}
