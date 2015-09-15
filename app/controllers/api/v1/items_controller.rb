class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find(params)
  end

  def find_all
    respond_with Item.find_all(params)
  end

  def random
    respond_with Item.random
  end
end
