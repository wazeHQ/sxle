require 'i18n'

module Sxle
  module Helpers
    module I18nHelper

      def safe_t(key, vars = {})
        if vars.include? :default
          text = t(key, default: vars.delete(:default))
        else
          text = t(key)
        end
        text = CGI::escape_html(text)

        vars.each do |name, value|
          value = CGI::escape_html(value) unless value.html_safe?
          text.gsub! "%{#{name}}", value
        end

        text.html_safe
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include Sxle::Helpers::I18nHelper
end
