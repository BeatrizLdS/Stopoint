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
        title = "Configurar Viagem"
        view.backgroundColor = .systemBackground
        print(viewModel?.location.name)
        // code origin
        // code destiny
        // departure date
        // adults number
        // childrens number
        // verify access token
    }

}
