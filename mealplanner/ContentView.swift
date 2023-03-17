//
//  ContentView.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewMeal = false
    @State var name = ""
    @State var imageURL = ""
    @State var dayToEat = ""
    @State var ingredients = ""
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink(
                        destination: ShowView(item: item),
                        label: {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text(item.imageURL).font(.caption).foregroundColor(.gray)
                            }
                            
                        })
                }.onDelete(perform: deleteMeal)
                
            }.listStyle(InsetListStyle())
            
            .navigationBarTitle("Meal Planner")
            .navigationBarItems(trailing: plusButton)
            .task {
                self.viewModel.fetchMeals()
            }
            .refreshable{
                self.viewModel.fetchMeals()
            }
            
        }.sheet(isPresented: $isPresentedNewMeal, content: {
            NewMealView(isPresented: $isPresentedNewMeal, name: $name, imageURL: $imageURL, dayToEat: $dayToEat, ingredients: $ingredients)
        })

    }
    
    private func deleteMeal(indexSet: IndexSet){
        let id = indexSet.map { viewModel.items[$0].id }
        DispatchQueue.main.async {
            let parameters: [String: Any] = ["id": id[0]]
            self.viewModel.deleteMeal(parameters: parameters)
            self.viewModel.fetchMeals()
            
            
        }
        viewModel.fetchMeals()
        
    }
    
    var plusButton: some View {
        Button(action: {
            isPresentedNewMeal.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
