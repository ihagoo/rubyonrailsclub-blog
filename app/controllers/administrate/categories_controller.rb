# frozen_string_literal: true

module Administrate
  class CategoriesController < AdministrateController
    # before_action :set_article, only: [:show, :edit, :update, :destroy, :destroy_cover_image]
    # before_action :set_categories, only: [:new, :edit, :show]

    # GET /articles or /articles.json
    def index
      @categories = Category.all
    end

    # GET /articles/1 or /articles/1.json
    def show
    end

    # GET /articles/new
    def new
      # @article = Article.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles or /articles.json
    def create
    end
  end
end
