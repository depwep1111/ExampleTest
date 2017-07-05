//
//  ViewController.swift
//  testGCD
//
//  Created by tran trung thanh on 7/4/17.
//  Copyright © 2017 tran trung thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var inactiveQueue: DispatchQueue!
    @IBOutlet var txtInput: UITextField!
    @IBOutlet var image: UIImageView!
    //let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    //var dataTask: URLSessionDataTask?
    @IBAction func btnTai(_ sender: Any) {
        /*
        if dataTask != nil {
            dataTask?.cancel()
        }
        // 2
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // 3
        //let expectedCharSet = NSCharacterSet.urlQueryAllowed
        
        // 4
        let url = NSURL(string: self.txtInput.text!)
        // 5
        dataTask = defaultSession.dataTask(with: url! as URL) {
            data, response, error in
            // 6
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            // 7
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.image.image = UIImage(data: data!)
                    
                }
            }
        }
        // 8
        dataTask?.resume()*/
        let imageURL: URL = URL(string: self.txtInput.text!)!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }).resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let queue = DispatchQueue(label: "thread")
        queue.sync {
            for i in 3..<101
            {
                if i % 3 == 0
                {
                    print("So chia het cho 3: ", i);
                }
            }
        }
        for j in 200..<501
        {
            if j % 5 == 0
            {
                print("So chia het cho 5: ", j);
            }
        }*/
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //concurrentQueues() // P.A 1
        concurrentQueues() // P.A 2
         if let queue = inactiveQueue {
         queue.activate()
         }
    }

    func concurrentQueues() {
         //let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility) // P.A 1
        //let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .concurrent)
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .initiallyInactive)
        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive]) // P.A 2
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
    }
}

