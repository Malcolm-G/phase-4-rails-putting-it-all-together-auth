class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        render json: recipes, include:[:user]
    end

    def create
        recipe = user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, include:[:user], status:201
        else
            render json: {errors:recipe.errors.full_messages}, status:422
        end
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
