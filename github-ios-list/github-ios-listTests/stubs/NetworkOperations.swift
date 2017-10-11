//
//  networkOperations.swift
//  github-ios-list
//
//  Created by Mateus Marques on 01/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Alamofire

typealias AlamofireResponse = (data: [String: Any], error: LocalizedError)

protocol AlamofireRequester {
    func makeRequest(_ urlConvertible: URLRequestConvertible, completion: @escaping (_ response: AlamofireResponse) -> Void)
}

class NetworkOperations: Operation {
    
    var requester: AlamofireRequester
    var isRunning: Bool = false
    var isDone: Bool = false
    
    init(requester: AlamofireRequester) {
        self.requester = requester
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return isRunning
    }
    
    override var isFinished: Bool {
        return isDone
    }
    
    override func start() {
        if self.isCancelled {
            self.finish()
        } else {
            isRunning = true
            main()
        }
    }
    
    func finish ()
    {
        self.willChangeValue(forKey: "isExecuting")
        isRunning = false
        self.didChangeValue(forKey: "isExecuting")
        
        self.willChangeValue(forKey: "isFinished")
        isDone = true
        self.didChangeValue(forKey: "isFinished")
    }
}
