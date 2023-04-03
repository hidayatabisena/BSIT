//
//  RecipeView.swift
//  BSIT-Idea
//
//  Created by Hidayat Abisena on 02/04/23.
//

import SwiftUI

// MARK: - Recipe Model
struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [String]
    let instructions: [String]
}

// MARK: - Recipe View
struct RecipeView: View {
    // MARK: - PROPERTIES
    let recipes = [
        Recipe(name: "Pasta Carbonara",               ingredients: ["spaghetti", "pancetta", "eggs", "parmesan cheese", "garlic"],
               instructions: [
                "Cook spaghetti according to package instructions.",
                "Fry pancetta and garlic until crispy.",
                "In a separate bowl, whisk together eggs and parmesan cheese.",
                "Drain spaghetti and add it to the pancetta and garlic.",
                "Remove from heat and stir in egg mixture.",
                "Serve hot."
               ]),
        Recipe(name: "Chicken Fajitas",
               ingredients: ["chicken breast", "bell peppers", "onions", "tortillas", "sour cream", "salsa"],
               instructions: [
                "Preheat oven to 375°F.",
                "Slice chicken breast, bell peppers, and onions into thin strips.",
                "In a large skillet, sauté chicken strips until browned on all sides.",
                "Add bell peppers and onions to the skillet and cook until tender.",
                "Wrap tortillas in foil and warm them in the oven for 10 minutes.",
                "Serve chicken and vegetables on tortillas with sour cream and salsa."
               ])
    ]
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink(destination: RecipeRow(recipe: recipe)) {
                    Text(recipe.name)
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

// MARK: - PREVIEW
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}

// MARK: - Recipe Row
struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text("Ingredients:")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("- " + ingredient)
                        .padding(.bottom, 2)
                }
                
                Text("Instructions:")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). " + recipe.instructions[index])
                        .padding(.bottom, 2)
                }
            }
            .padding()
        }
    }
}
