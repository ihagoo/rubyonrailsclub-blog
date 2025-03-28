# frozen_string_literal: true

module Administrate
  class AuthorsController < AdministrateController
    before_action :set_author, only: [:show, :edit, :update, :destroy]

    # GET /authors or /authors.json
    def index
      @authors = Author.all
    end

    # GET /authors/1 or /authors/1.json
    def show
    end

    # GET /authors/new
    def new
      @author = Author.new
    end

    # GET /authors/1/edit
    def edit
    end

    def update
      respond_to do |format|
        if @author.update(author_params)
          format.html { redirect_to(administrate_author_url(@author), notice: "Autor atualizado com sucesso!") }
          format.json { render(:show, status: :ok, location: @author) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    def destroy
      respond_to do |format|
        format.html do
          if @author.articles.count > 0
            redirect_to(
              administrate_authors_path,
              alert: "Existem artigos associados a esse autor! Não é possivel apaga-lo!",
            )
          else
            @author.destroy!
            redirect_to(administrate_authors_path, status: :see_other, notice: "Autor apagado com sucesso!")
          end
        end
        format.json { head(:no_content) }
      end
    end

    # POST /authors or /authors.json
    def create
      @author = Author.new(author_params)

      respond_to do |format|
        if @author.save
          format.html { redirect_to(administrate_author_url(@author), notice: "Autor criado com sucesso!") }
          format.json { render(:show, status: :created, location: @author) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @author.errors, status: :unprocessable_entity) }
        end
      end
    end

    private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(
        :name,
        :description,
        :facebook_profile_url,
        :instagram_profile_url,
        :twitter_profile_url,
        :linkedin_profile_url,
        :youtube_profile_url,
      )
    end
  end
end
