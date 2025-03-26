# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    # before_action :set_article, only: [:show, :edit, :update, :destroy, :destroy_cover_image]
    # before_action :set_categories, only: [:new, :edit, :show]

    # GET /categories or /categories.json
    def index
      @categories = Category.all
    end

    # GET /articles/1 or /articles/1.json
    def show
    end

    # GET /categories/new
    def new
      @category = Category.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles or /articles.json
    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to(administrate_category_url(@category), notice: "Categoria criada com sucesso!") }
          format.json { render(:show, status: :created, location: @category) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
