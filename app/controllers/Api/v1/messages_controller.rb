class MessagesController < ApplicationController
  before_action :authenticate, only: [:departments, :create_department, :destroy_department]

  def messages
    result = Message.messages(params, @user)
    render(result)
  end


  def create_message
    result = Message.create_message(params, @user)
    render(result)
  end

  def destroy_message
    result = Message.destroy_message(params, @user)
    render(result)
  end
end
