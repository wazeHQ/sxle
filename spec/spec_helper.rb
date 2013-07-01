$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_support/all'
require 'action_view'

module Rails
  class Engine
  end
end

require 'sxle'
