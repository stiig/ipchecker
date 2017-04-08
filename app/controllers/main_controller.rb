# frozen_string_literal: true

class MainController < ApplicationController
  def index
    render plain: 'nothing to show'
  end
end
