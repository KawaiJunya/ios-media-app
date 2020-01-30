//
//  ArticleListRepository.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/26.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

enum ResponseError: Error {
    case none
}

class ArticleListRepository {
    func getArticles(page: Int) -> Observable<[Article]> {
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters:[String: Any] = [
            "page":     page,
            "per_page": 30
        ]
        return Observable.create { observer in
            Alamofire.request(
                PathValues.GET_ARTICLES,
                method:     .get,
                parameters: parameters,
                encoding:   URLEncoding(destination: .queryString),
                headers:    headers
            ).responseJSON { response in
                do {
                    guard let data = response.data else {
                        throw ResponseError.none
                    }
                    //Jsonをモデルにデコード
                    let result = try JSONDecoder().decode([Article].self, from: data)
                    observer.onNext(result)
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
