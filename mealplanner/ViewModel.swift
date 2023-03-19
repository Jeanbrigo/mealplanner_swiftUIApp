//
//  ViewModels.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [MealModel]()
    let prefixUrl = "https://mealplanner-backend-fcov.onrender.com"
    
    init() {
        fetchMeals()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
    }
    
    //MARK: - Retrieve data
    func fetchMeals() {
        guard let url = URL(string: "\(prefixUrl)/meals/") else {
            print("Not found url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([MealModel].self, from: data)
                    DispatchQueue.main.async {
                        self.items = result
                        print("lol")
                    }
                } else {
                    print("No data")
                }
            } catch let JsonError {
                print("fetch retrieve json error:", JsonError)
            }
        }.resume()
    }
    
    //MARK: - Create data
    func createMeal(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/meals/") else {
            print("Not found url")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(MealModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No data")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError)
            }
        }.resume()
    }
    
    //MARK: - Update data
    func updateMeal(parameters: [String: Any])  {
        let idMeal = parameters["id"]
        guard let url = URL(string: "\(prefixUrl)/meals/\(idMeal!)/") else {
            print("Not found url")
            return
        }
        print(url)
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(MealModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                        
                    }
                } else {
                    print("No data")
                }
            } catch let JsonError {
                print("fetch json error:", JsonError)
            }
        }.resume()
    }
    
    //MARK: - Delete data
    func deleteMeal(parameters: [String: Any]) {
        let idMeal = parameters["id"]
        guard let url = URL(string: "\(prefixUrl)/meals/\(idMeal!)/") else {
            print("Not found url")
            return
        }
        let data = try? JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }

            
        }.resume()
    }
}
