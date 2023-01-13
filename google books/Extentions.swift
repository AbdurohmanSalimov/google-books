//
//  Extentions.swift
//  google books
//
//  Created by Azizbek Salimov on 13/01/23.
//

import UIKit

extension UIViewController {
    func showAlertWrong(){
        let alert = UIAlertController(title: "Try again", message: "Something gona wrong", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showAlertDelete(){
        
    }
}
