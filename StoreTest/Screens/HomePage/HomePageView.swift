//
//  HomePageView.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 18.03.2023.
//

import SwiftUI
import Kingfisher

struct HomePageView: View {
    
    @StateObject var viewModel = HomePageViewModel()

    var body: some View {
        ZStack {
            Color(hex: "FAF9FF")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView (showsIndicators: false) {
                
                VStack (alignment: .leading) {
                    
                    HomeNavBar()
                    
                    SearchBar(text: $viewModel.search)
                    
                    CategoriesView()
                    
                    VStack {
                        // Latest
                        VStack {
                            HStack {
                                Text("Latest")
                                    .font(.custom("Montserrat-SemiBold", size: 24))

                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("View all")
                                        .font(.custom("Montserrat-SemiBold", size: 13))
                                        .foregroundColor(.gray)
                                })
                            }
                            .padding(.horizontal)
                        .padding(.top, 25)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    
                                    ForEach(0 ..< $viewModel.latestProducts.count, id: \.self) { i in
                                        LatestItem(category: $viewModel.latestProducts[i].category, name: $viewModel.latestProducts[i].name, price: $viewModel.latestProducts[i].price, urlString: $viewModel.latestProducts[i].image_url)
                                    }
                                }
                                .padding(.leading)
                                .padding(.trailing)
                            }
                        }
                        
                        //Flash Sale
                        VStack {
                            HStack {
                                Text("Flash Sale")
                                    .font(.custom("Montserrat-SemiBold", size: 24))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("View all")
                                        .font(.custom("Montserrat-SemiBold", size: 13))
                                        .foregroundColor(.gray)
                                })
                            }
                            .padding(.horizontal)
                            .padding(.top, 13)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                
                                HStack {
                                    
                                    ForEach(0 ..< $viewModel.flashSaleProducts.count, id: \.self) { i in
                                        FlashSaleItem(category: $viewModel.flashSaleProducts[i].category,
                                                      name: $viewModel.flashSaleProducts[i].name,
                                                      discount: $viewModel.flashSaleProducts[i].discount,
                                                      price: $viewModel.flashSaleProducts[i].price, urlString: $viewModel.flashSaleProducts[i].image_url)
                                    }
                                
                                }
                                .padding(.leading)
                                .padding(.trailing)
                                //ZStack
                            }
                        }
                        
                        BrandsView()
                    }
                    .task {
                        await viewModel.fetchData()
                    }

                }
                .padding(.bottom, 80)
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct HomeNavBar: View {
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        HStack {
            Button (action: {
                
            }, label: {
                Image("menu").resizable().frame(width: 22, height: 22)
            })
            .padding(.bottom)
            
            
            VStack {
                HStack {
                    Text("Trade by")
                        .font(.custom("Montserrat-Bold", size: 24))
                    + Text (" bata")
                        .font(.custom("Montserrat-Bold", size: 24))
                    .foregroundColor(.blue)
                }
                .padding(.bottom)
                .padding(.leading, 22)
                .frame(maxWidth: .infinity)
            }
            
            
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.green)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                
                Button (action: {
                    
                }, label: {
                    HStack {
                        Text("Location")
                            .font(.custom("Montserrat-Regular", size: 10))
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 10, height: 5)
                            .foregroundColor(.black)
                    }
                })
            }
            
        }
        .padding(.horizontal)
    }
}

struct SearchBar: View {
    //@StateObject var viewModel = HomePageViewModel()
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                
                TextField("What are you looking for?", text: $text)
                    .multilineTextAlignment(.center)
                Image("search")
                    .resizable()
                    .frame(width: 19, height: 19)
                    .padding(.trailing, 8)
            }
            .padding(.all, 10)
            .background(Color(hex: "F5F6F7"))
            .cornerRadius(20.0)
            .padding(.horizontal)
        }
        .padding(.top, 11)
    }
}

// Categoties
struct CategoryItemView: View {
    @StateObject var viewModel = HomePageViewModel()
    var icon: String
    var title: String
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color(hex: "EEEFF4"))
                        .frame(width: 55, height: 55)
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
                
                Text(title)
                    .font(.custom("Montserrat-Light", size: 10))
                    .foregroundColor(.black)
            }
        })
    }
}
struct CategoriesView: View {
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0 ..< viewModel.categiroes.count) { category in
                    CategoryItemView(icon: viewModel.categiroes[category].icon, title: viewModel.categiroes[category].title)
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .padding(.top, 17)
    }
}

// Latest
struct LatestItem: View {
    @Binding var category: String
    @Binding var name: String
    @Binding var price: Float
    @Binding var urlString: String
    var body: some View {
        
        
        ZStack {
            
            VStack {
                KFImage(URL(string: urlString))
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 130.0,  minHeight: 175.0, maxHeight: 175.0)
                    .contentShape(Rectangle())
            }
            
            Image("gradient")
                .resizable()

            VStack {
                
                Spacer()
                
                HStack {
                    
                    Text(category)
                        .font(.custom("Montserrat-SemiBold", size: 6))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(Color(hex: "c4c4c4"))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(name)
                        .font(.custom("Montserrat-Bold", size: 10))
                        .padding(.bottom, 17)
                        .foregroundColor(Color.white)
                        .frame(alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("$\(String(format: "%.2f", price))")
                        .font(.custom("Montserrat-Bold", size: 10))
                        .padding(.bottom, 7)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color(hex: "E5E9EF"))
                            .frame(width: 25, height: 25)
                        
                        Button(action: {
                            print("tapped")
                        }, label: {
                            Image("plus")
                                .resizable()
                                .frame(width: 12, height: 12)
                        })
                    }
                    .padding(.bottom, 7)
                }
            }
            .frame(width: 116)
            .padding(.horizontal, 7)
        }
        .background(.red)
        .frame(maxWidth: 130, maxHeight: 175)
        .cornerRadius(10)
    }
}


// Flash Sale
struct FlashSaleItem: View {
    @Binding var category: String
    @Binding var name: String
    @Binding var discount: Int
    @Binding var price: Float
    @Binding var urlString: String
    var body: some View {
        ZStack {
            ZStack {
                KFImage(URL(string: urlString))
                    .resizable()
                    .scaledToFill()
                    .contentShape(Rectangle())
                
                Image("gradient")
                    .resizable()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 185, height: 230)
            
            VStack {
                
                HStack {
                    Text("\(discount)% off")
                        .font(.custom("Montserrat-SemiBold", size: 13))
                        .padding(.horizontal, 9)
                        .padding(.vertical, 4)
                        .foregroundColor(.white)
                        .background(Color(hex: "F93A3A"))
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                
                HStack {
                    Text(category)
                        .font(.custom("Montserrat-SemiBold", size: 13))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(Color(hex: "c4c4c4"))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(name)
                        .font(.custom("Montserrat-Bold", size: 13))
                        .padding(.bottom, 17)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    Text("$\(String(format: "%.2f", price))")
                        .font(.custom("Montserrat-Bold", size: 13))
                        .padding(.bottom, 7)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    HStack {
                        //Favourite Button
                        ZStack {
                            Circle()
                                .fill(Color(hex: "E5E9EF"))
                                .frame(width: 27, height: 27)
                            
                            Button(action: {
                                
                            }, label: {
                                Image("heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12, height: 12)
                            })
                        }
                        
                        //Plus Button
                        ZStack {
                            Circle()
                                .fill(Color(hex: "E5E9EF"))
                                .frame(width: 37, height: 37)
                            
                            Button(action: {
                                
                            }, label: {
                                Image("plus")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                            })
                        }
                    }
                }
                
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 7)
        }
        .frame(width: 185, height: 230)
        .cornerRadius(10)
    }
}

// Brands
struct BrandItemView: View {
    var icon: String
    var title: String
    
    var body: some View {
        ZStack {
            ZStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                Image("gradient")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .background(Color(hex: "E5E9EF"))

            
            VStack {
                Spacer()
                
                Text(title)
                    .font(.custom("Montserrat-Bold", size: 14))
                    .padding(.bottom, 17)
                    .foregroundColor(Color.white)
                    .frame(alignment: .leading)
            }
            .frame(width: 115, height: 150)
        }
        .frame(width: 115, height: 150)
        .cornerRadius(10, corners: .allCorners)
    }
}
struct BrandsView: View {
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Brands")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("View all")
                        .font(.custom("Montserrat-SemiBold", size: 13))
                        .foregroundColor(.gray)
                })
            }
            .padding(.horizontal)
            .padding(.top, 13)
            
            ScrollView (.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(0 ..< 5) { i in
                        BrandItemView(icon: viewModel.brands[i].icon, title: viewModel.brands[i].title)
                    }
                }
                .padding(.leading)
                .padding(.trailing)
                //ZStack
            }
        }
    }
}
