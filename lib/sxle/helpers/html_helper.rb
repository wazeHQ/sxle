module Sxle
  module Helpers
    module HtmlHelper
      def lines_to_paragraphs(text)
        return '' if text.nil? or text =~ /^ *$/
        text.split("\n").map { |line| content_tag('p', line) }.join().html_safe
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include Sxle::Helpers::HtmlHelper
end
