class ContentService
  def initialize
    @openai_service = OpenAiService.new
  end

  def relevant_ideas(article_title, ideas)
    system_prompt = "You are an expert business analyst with deep knowledge of various industries and business models."
    user_prompt = "Given the article title '#{article_title}', analyze the following list of business ideas and return the names of all the relevant ideas, in order from most relevant to least relevant, separated by commas:\n\n#{ideas.map(&:name).join(', ')}"

    response = @openai_service.generate_content(system_prompt, user_prompt)
    response.split(',').map(&:strip)
  end

  def generate_content(idea)
    system_prompt = "You are a professional business writer with expertise in creating informative and engaging content about various business models and industries."
    user_prompt = "Write a detailed section about starting a #{idea.name} business. Include information about the market, potential revenue (average: $#{idea.average_revenue}), startup costs (average: $#{idea.average_cost_to_start}), key challenges, and success strategies. The section should be informative and encouraging to potential entrepreneurs. Keep it to a few paragraphs."

    @openai_service.generate_content(system_prompt, user_prompt)
  end

  def generate_section_title(idea)
    system_prompt = "You are a creative content strategist specializing in business and entrepreneurship topics."
    user_prompt = "Generate an engaging section title for an article about starting a #{idea.name} business. The title should start with 'Start a', 'Create a', or 'Become a', be 4-8 words long, and end with the average monthly revenue in this format: ($X/month). Use #{idea.average_revenue} as the monthly revenue."

    response = @openai_service.generate_content(system_prompt, user_prompt)
    response.split("\n").map { |title| title.gsub(/^\d+\.\s*/, '') }
  end

  def generate_introduction(article_title)
    system_prompt = "You are an experienced business journalist known for writing compelling introductions that grab readers' attention."
    user_prompt = "Write an engaging introduction for an article titled '#{article_title}'. The introduction should hook the reader, provide a brief overview of what the article will cover, and highlight the potential benefits of the business idea."

    @openai_service.generate_content(system_prompt, user_prompt)
  end

  def optimise_content(article_title, idea)
    system_prompt = "You are an SEO expert and content optimizer with a deep understanding of business and entrepreneurship topics."
    user_prompt = "Optimize the following content about starting a #{idea.name} business to fit seamlessly into an article titled '#{article_title}'. Rewrite the beginning sentence to flow naturally within the article context, and then continue with the rest of the original content. Here's the content to optimize:\n\n#{idea.content}\n\nPlease provide only the optimized content in your response."

    @openai_service.generate_content(system_prompt, user_prompt)
  end
end
