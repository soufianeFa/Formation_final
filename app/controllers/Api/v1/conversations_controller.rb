class ConversationsController < ApplicationController
  before_action :authenticate, only: [:departments, :create_department, :destroy_department]

  def conversations
    result = Conversation.conversations(params, @user)
    render(result)
  end


  def create_conversation
    result = Conversation.create_conversation(params, @user)
    render(result)
  end

  def destroy_conversation
    result = Conversation.destroy_department(params, @user)
    render(result)
  end
end
