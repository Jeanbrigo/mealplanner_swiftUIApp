//
//  NewMealView.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import SwiftUI

struct NewMealView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var name: String
    @Binding var imageURL: String
    @Binding var dayToEat: String
    @Binding var ingredients: String
    @State var isAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Add a meal")
                        .font(Font.system(size: 16, weight: .bold))
                        .foregroundColor(Color.yellow)
                    
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        .foregroundColor(Color.blue)
                    
                    TextField("Image URL", text: $imageURL)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        .foregroundColor(Color.blue)
                    
                    TextField("Which Day To Eat", text: $dayToEat)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        .foregroundColor(Color.blue)
                    
                    TextField("Ingredients", text: $ingredients)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        .foregroundColor(Color.blue)
                    Spacer()
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("Empty Info")
                        let message = Text("Make sure to enter all the meal info!")
                        return Alert(title: title, message: message)
                    })
            }
            
            .navigationTitle("New meal")
            .navigationBarItems(leading: leading, trailing: trailing)
            .background(Color.blue)
        }
    }
    var leading: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel").foregroundColor(Color.yellow)
        })
    }
    
    var trailing: some View {
        Button(action: {
            if name != "" && imageURL != "" && dayToEat != "" && ingredients != "" {
                let parameters: [String: Any] = ["name": name, "imageURL": imageURL, "dayToEat": dayToEat, "ingredients": ingredients]
                viewModel.createMeal(parameters: parameters)

                
                isPresented.toggle()
                viewModel.fetchMeals()

                    
            } else {
                isAlert.toggle()
            }
            
        }, label: {
            Text("Add").foregroundColor(Color.yellow)
        })
    }
}

//struct NewMealView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMealView()
//    }
//}
