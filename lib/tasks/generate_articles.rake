namespace :articles do
  desc "Generate articles using ContentService"
  task generate: :environment do
    content_service = ContentService.new

    article_titles = [
      "Business Ideas for Doctors",
      "Business Ideas for Accountants",
      "Business Ideas for Dentists"
    ]

    article_titles.each do |article_title|
      puts "Generating article: #{article_title}"

      # Find relevant ideas
      all_ideas = BusinessIdea.all
      relevant_idea_names = content_service.relevant_ideas(article_title, all_ideas)
      relevant_ideas = BusinessIdea.where(name: relevant_idea_names)

      # Generate introduction
      introduction = content_service.generate_introduction(article_title)

      # Create the article
      article = Article.create!(title: article_title, introduction: introduction)

      relevant_ideas.each do |idea|
        puts "Processing idea: #{idea.name}"

        # Generate section title if not present
        if idea.title.blank?
          idea.title = content_service.generate_section_title(idea).first
          idea.save!
        end

        # Generate content if not present
        if idea.content.blank?
          idea.content = content_service.generate_content(idea)
          idea.save!
        end

        # Optimize content
        optimized_content = content_service.optimise_content(article_title, idea)

        # Create ArticleSection
        ArticleSection.create!(
          article: article,
          business_idea: idea,
          content: optimized_content
        )

        puts "Created article section for #{idea.name}"
      end

      puts "Completed article: #{article_title}"
    end

    puts "Article generation complete!"
  end
end
