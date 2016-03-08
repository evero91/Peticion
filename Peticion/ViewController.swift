//
//  ViewController.swift
//  Peticion
//
//  Created by Everardo Guevara Soto on 03/03/16.
//  Copyright © 2016 Everardo Guevara Soto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtAutores: UITextView!
    @IBOutlet weak var imgPortada: UIImageView!
    @IBOutlet weak var lblEstadoPeticion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtISBN.text = "978-84-376-0494-7"
        lblTitulo.text = ""
        txtAutores.text = ""
        lblEstadoPeticion.text = ""
    }
    
    @IBAction func limpiar() {
        txtISBN.text = ""
        lblTitulo.text = ""
        txtAutores.text = ""
        lblEstadoPeticion.text = ""
        imgPortada.image = nil
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        txtISBN.resignFirstResponder()
    }
    
    @IBAction func textFieldDoneEditing(textField: UITextField) {
        lblEstadoPeticion.text = ""
        let url = NSURL(string: "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(txtISBN.text!)")
        
        if let datos = NSData(contentsOfURL: url!) {
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos, options: NSJSONReadingOptions.MutableLeaves)
                let dicJson = json as! NSDictionary
                
                if let dicISBN = dicJson["ISBN:\(txtISBN.text!)"] as! NSDictionary! {
                    
                    lblTitulo.text = dicISBN["title"] as! NSString as String
                    imgPortada.image = nil
                    
                    if let dicCover = dicISBN["cover"] as! NSDictionary! {
                        if let url  = NSURL(string: dicCover["medium"] as! NSString as String), data = NSData(contentsOfURL: url) {
                            imgPortada.image = UIImage(data: data)
                        }
                    }
                    
                    let dicAutores = dicISBN["authors"] as! NSArray
                    var autores = ""
                    
                    for autor in dicAutores {
                        autores += "- \(autor["name"]!!)\n"
                    }
                    
                    txtAutores.text = autores

                } else {
                    limpiar()
                    lblEstadoPeticion.text = "No se encontro ISBN"
                }
            } catch _ {
                limpiar()
                lblEstadoPeticion.text = "Ocurrió un error al obtener la información"
            }
        } else {
            limpiar()
            lblEstadoPeticion.text = "Error de conexión"
        }
    }
    
}
