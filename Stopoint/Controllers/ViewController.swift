//
//  ViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 13/10/22.
//

import UIKit

class ViewController: UIViewController {
    var viewModel :ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        fetchData()
    }

    // Primeira chamada a API
    func fetchData() {
        viewModel!.generateAccessToken()
    }
}
