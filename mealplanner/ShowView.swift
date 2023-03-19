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
                AsyncImage(url: URL(string: item.imageURL),
                           content: { image in
                    image.resizable().border(Color.yellow, width: 5)
                        .cornerRadius(10)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 600, maxHeight: 200, alignment: .center)
                                    .padding()
                           },
                           placeholder: {
                               ProgressView()
                           }
                       )
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
                
                TextField("Ingredients", text: $ingredients, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                    .foregroundColor(Color.blue)
                Spacer()
                
            }.padding()
                .onAppear(perform: {
                    self.name = item.name
                    self.imageURL = item.imageURL
                    self.dayToEat = item.dayToEat
                    self.ingredients = item.ingredients
                    
                })
                
        }
        
        .navigationTitle("Edit meal")
        .navigationBarItems(trailing: trailing)
        .accentColor(Color.yellow)
        .background(Color.blue)
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
            Text("Save").foregroundColor(Color.yellow)
        })
    }
}

//
//struct ShowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowView()
//    }
//}
