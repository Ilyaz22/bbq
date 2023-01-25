# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# убирает div с классом «field_with_errors» у формы если не проходит валидация
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
