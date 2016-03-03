//
//  ViewController.swift
//  Peticion
//
//  Created by Everardo Guevara Soto on 03/03/16.
//  Copyright © 2016 Everardo Guevara Soto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtContenido: UITextView!
    @IBOutlet weak var txtISBN: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtISBN.text = "978-84-376-0494-7"
        txtContenido.layer.borderWidth = 1
        txtContenido.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func limpiar() {
        txtContenido.text = ""
        txtISBN.text = ""
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        txtISBN.resignFirstResponder()
    }
    
    @IBAction func textFieldDoneEditing(textField: UITextField) {
        let url = NSURL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(txtISBN.text!)")
        if let datos = NSData(contentsOfURL: url!) {
            self.txtContenido.textColor = UIColor.blackColor()
            self.txtContenido.text = String(data: datos, encoding: NSUTF8StringEncoding)
        } else {
            self.txtContenido.textColor = UIColor.redColor()
            self.txtContenido.text = "Error: No hubo respuesta"
        }
        
    }
    
}
