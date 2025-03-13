# frozen_string_literal: true

namespace :dev do
  desc "Add articles to the database"
  task add_articles: :environment do
    show_spinner("Iniciando o cadastro de Artigos!") { add_articles }
  end

  def add_articles
    50.times do
      Article.create(
        title: Faker::Lorem.sentence.delete("."),
        body: Faker::Lorem.paragraph(sentence_count: rand(100..200)),
      )
    end
  end

  def show_spinner(msg_start, msg_end = "Artigos Cadastrados!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
