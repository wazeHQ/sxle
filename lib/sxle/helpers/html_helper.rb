module Sxle
  module Helpers
    module HtmlHelper
      def lines_to_paragraphs(text)
        convert_lines(text, nil) { |line| content_tag('p', line) }
      end

      def lines_to_br(text)
        convert_lines(text, tag(:br)) { |line| CGI::escape_html(line) }
      end

      private
      def convert_lines(text, join_with, &block)
        return '' if text.nil? or text =~ /^ *$/
        text.split("\n").map { |line| yield(line) }.join(join_with).html_safe
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include Sxle::Helpers::HtmlHelper
end
