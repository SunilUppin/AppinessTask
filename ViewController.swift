//
//  ViewController.swift
//  AssignmentAppiness
//
//  Created by Sunil on 24/09/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

struct Person: Codable {
    let name, dob: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let localData = self.readLocalFile(forName: "data") {
            self.parse(jsonData: localData)
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "data", ofType: "json") {
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
           
            if let decodedData = try? JSONDecoder().decode([Person].self, from: jsonData) {
                
                let sortedByage = decodedData.sorted(by: { $0.dob < $1.dob})
                let name = sortedByage.filter { (person) -> Bool in
                    let intAge = Int(person.dob.components(separatedBy: "/").first ?? "0")
                    if !((intAge ?? 0) % 4 == 0) {
                        return true
                    }
                    return false
                }
                print("================================")
                print("=== Sorted By Age in Ascending order ===")
                print(sortedByage)
                print("================================")
                print("=== Only those DOB that is not a leap year ===")
                print(name)

            }
            print("===================================")
        }
    }
}
