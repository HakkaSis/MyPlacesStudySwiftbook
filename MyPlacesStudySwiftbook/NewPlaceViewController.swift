//
//  NewPlaceViewController.swift
//  MyPlacesStudySwiftbook
//
//  Created by Евгений Скилиоти on 18.05.2020.
//  Copyright © 2020 Евгений Скилиоти. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
// MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
}

// MARK: - TextField Delegate
extension NewPlaceViewController: UITextFieldDelegate {
//    скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
