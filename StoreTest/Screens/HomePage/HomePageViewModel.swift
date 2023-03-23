//
//  HomePageViewModel.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 20.03.2023.
//

import SwiftUI
import Combine


@MainActor final class HomePageViewModel: ObservableObject {
    
    @Published var latestProducts: [LatestProduct] = []
    @Published var flashSaleProducts: [FlashSaleProduct] = []
    let latestUrl = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    let flashUrl = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
    
    @Published var search: String = ""
    
    let categiroes = [
        CategoryItem(icon: "phone", title: "Phone"),
        CategoryItem(icon: "headphone", title: "Headphones"),
        CategoryItem(icon: "games", title: "Games"),
        CategoryItem(icon: "car", title: "Cars"),
        CategoryItem(icon: "bed", title: "Furniture"),
        CategoryItem(icon: "robot", title: "Kids"),
    ]
    
    let brands = [
        BrandItem(icon: "newbalance", title: "New balance"),
        BrandItem(icon: "samsung", title: "Samsung"),
        BrandItem(icon: "nike", title: "Nike"),
        BrandItem(icon: "bmw", title: "BMW"),
        BrandItem(icon: "adidas", title: "Adidas")
    ]
    
    func fetchData() async {
        
        guard let url = URL(string: latestUrl) else {
            print("Could not create a url from \(latestUrl)")
            
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Try to decode JSON data into our own data structures
            guard let latest = try? JSONDecoder().decode(LatestProducts.self, from: data) else {
                print("Could not decode returned JSON data from \(latestUrl)")
                return
            }
            self.latestProducts = latest.latest
            print("JSON returned! count: \(latestProducts.count)")
        } catch {
            print("Could not get data from \(latestUrl)")
        }
        
        //second fetching
        
        guard let url2 = URL(string: flashUrl) else {
            print("Could not create a url from \(flashUrl)")
            
            return
        }
        
        do {
            let (data2, _) = try await URLSession.shared.data(from: url2)
            
            //Try to decode JSON data into our own data structures
            guard let flash = try? JSONDecoder().decode(FlashSaleProducts.self, from: data2) else {
                print("Could not decode returned JSON data from \(flashUrl)")
                return
            }
            self.flashSaleProducts = flash.flash_sale
            print("JSON returned! count: \(flashSaleProducts.count)")
        } catch {
            print("Could not get data from \(flashUrl)")
        }
        
    }
}


