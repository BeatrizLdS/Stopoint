//
//  FormViewController.swift
//  Stopoint
//
//  Created by Beatriz Leonel da Silva on 19/10/22.
//

import UIKit

class FormViewController: UIViewController {

    var viewModel: FormViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(viewModel?.location.name)
    }

}
