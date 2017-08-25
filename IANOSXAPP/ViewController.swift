//
//  ViewController.swift
//  IANOSXAPP
//
//  Created by Peter on 8/21/17.
//  Copyright © 2017 Peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var respuesta: UILabel!
    
    @IBAction func pressbutton(_ sender: Any) {
        
        
        
        print("a punto de hacer peticion")
        print("\(usuario.text!)")
        
        respuesta.numberOfLines = 50
        self.respuesta.text =  ("" as! String)
        //
        
        var session = URLSession.shared
        var err: NSError?
        
        let soapMessage = "<?xml version='1.0'?><SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/'><SOAP-ENV:Body xmlns:NS1='urn:androidserviceIntf-Iandroidservice' SOAP-ENV:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><NS1:login><usr xsi:type='xsd:string'>\(usuario.text!)</usr><password xsi:type='xsd:string'>\(password.text!)</password></NS1:login></SOAP-ENV:Body></SOAP-ENV:Envelope>"
        
        print(soapMessage)
        
        let urlString = "http://192.168.1.67:8070/soap/Iandroidservice"
        let url = NSURL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url! as URL)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        //theRequest.timeoutInterval = 10
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        let connection = NSURLConnection(request: theRequest as URLRequest, delegate: self, startImmediately: true)
        
        var task = session.dataTask(with: theRequest as URLRequest, completionHandler: {data, response, error -> Void in
            
            do{
            print("Response: \(response)")
            
            
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            DispatchQueue.main.async() {
                self.respuesta.text =  ("\(strData)")

                print("Response: \(response)")
                }
            }
            catch {
            DispatchQueue.main.async() {
                self.respuesta.text =  ("\(response)")

            print("Response: \(response)")
        
                }}})
        task.resume()
        
        session.finishTasksAndInvalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

