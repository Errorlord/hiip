class ThingsController < ApplicationController
  def index
    @node = Node.all
  end
end
