module PromptInput
  def select_input (message, values_list)
    @prompt.select(message, value_list, cycle: true, filter: true, per_page: 10)
  end
end
