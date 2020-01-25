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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("article list")
        // Do any additional setup after loading the view.
        viewModel.getArticleList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
