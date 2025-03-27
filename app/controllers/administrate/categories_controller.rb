# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
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

    # GET /categories/1/edit
    def edit
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to(administrate_category_url(@category), notice: "Categoria atualizada com sucesso!") }
          format.json { render(:show, status: :ok, location: @category) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @category.errors, status: :unprocessable_entity) }
        end
      end
    end

    def destroy
      respond_to do |format|
        format.html do
          if @category.articles.count > 0
            redirect_to(
              administrate_categories_path,
              alert: "Existem artigos associados a essa categoria! Não é possivel apaga-la!",
            )
          else
            @category.destroy!
            redirect_to(administrate_categories_path, status: :see_other, notice: "Categoria apagada com sucesso!")
          end
        end
        format.json { head(:no_content) }
      end
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

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
