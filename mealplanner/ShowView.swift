//
//  ShowView.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import SwiftUI

struct ShowView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let item: MealModel
    @State var name = ""
    @State var imageURL = ""
    @State var dayToEat = ""
    @State var ingredients = ""
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Add a meal")
                    .font(Font.system(size: 16, weight: .bold))
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                TextField("Image URL", text: $imageURL)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                TextField("Which Day To Eat", text: $dayToEat)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                TextField("Ingredients", text: $ingredients)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                Spacer()
                
            }.padding()
                .onAppear(perform: {
                    self.name = item.name
                    self.imageURL = item.imageURL
                    self.dayToEat = item.dayToEat
                    self.ingredients = item.ingredients
                    
                })
                
        }
        
        .navigationBarTitle("Edit meal", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    var trailing: some View {
        Button(action: {
            if name != "" && imageURL != "" && dayToEat != "" && ingredients != "" {
                let parameters: [String: Any] = ["id":item.id,  "name": name, "imageURL": imageURL, "dayToEat": dayToEat, "ingredients": ingredients]
                viewModel.updateMeal(parameters: parameters)
                presentationMode.wrappedValue.dismiss()
                viewModel.fetchMeals()
            }
            viewModel.fetchMeals()

        }, label: {
            Text("Save")
        })
    }
}

//
//struct ShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowView()
//    }
//}
