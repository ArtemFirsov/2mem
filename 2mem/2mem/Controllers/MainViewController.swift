//
//  MainViewController.swift
//  2mem
//
//  Created by Artem Firsov on 9/21/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func nextButton(_ sender: Any) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return alertWindow()}
        performSegue(withIdentifier: "toGallery", sender: nil)
    }
    
    func alertWindow() {
        let alertController = UIAlertController(title: "Ошибка", message: "Пустое поле для поиска", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGallery" {
            if let dst = segue.destination as? ImagesViewController {
                dst.inputId = self.searchTextField.text!
            }
        }
    }
}
