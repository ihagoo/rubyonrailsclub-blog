# frozen_string_literal: true

namespace :dev do
  desc "Reset the database"
  task reset: :environment do
    system("rails db:drop")
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
    system("rails dev:add_categories")
    system("rails dev:add_articles")
  end

  desc "Add categories to the database"
  task add_categories: :environment do
    show_spinner("Adicionando categorias no bando de dados!", "Categorias adicionadas!") { add_categories }
  end

  desc "Add articles to the database"
  task add_articles: :environment do
    show_spinner("Iniciando o cadastro de Artigos!", "Artigos adidionados!") { add_articles }
  end

  def add_categories
    ["Ruby", "Rails", "WSL", "Linux"].each do |name|
      Category.create!(name: name)
    end
  end

  def add_articles
    50.times do
      article = Article.create(
        title: Faker::Lorem.sentence.delete("."),
        body: Faker::Lorem.paragraph(sentence_count: rand(100..200)),
        category: Category.all.sample,
      )

      image_id = rand(1..3)

      article.cover_image.attach(
        io: File.open(Rails.root.join("lib/tasks/images/article_#{image_id}.jpg")),
        filename: "article_#{image_id}.jpg",
      )
    end
  end

  def show_spinner(msg_start, msg_end)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
