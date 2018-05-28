//
//  ViewController.swift
//  PeticionOpenLib
//
//  Created by Fernando Rojas Hidalgo on 5/28/18.
//  Copyright © 2018 Rohisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var txtParametro: UITextField!
    
    
    func sincrono(){
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + txtParametro.text!
        let url =  NSURL(string: urls)
        let datos:NSData? =  NSData(contentsOf: url! as URL)
        let texto = NSString(data:datos! as Data, encoding:String.Encoding.utf8.rawValue)
        lblMensaje.text = texto! as String
    }
    

    func asincrono(){
      
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + self.txtParametro.text!
        let url = NSURL(string: urls)
        let sesion = URLSession.shared
        
        let bloque = {(datos: Data?, resp : URLResponse?, error : Error?) -> Void in let texto = NSString(data: datos! as Data, encoding:String.Encoding.utf8.rawValue)
             DispatchQueue.main.async {
                self.lblMensaje.text = texto! as String}}
        let dt = sesion.dataTask(with: url! as URL,completionHandler: bloque)
        dt.resume()
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Invocar(_ sender: UIButton) {
        if (Network.reachability?.isReachable)!{
              sincrono()
        }else{
            lblMensaje.text = "No hay internet"
            print("Error: No hay conexión a Internet")
        }
    }

}
    


