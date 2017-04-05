class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  class << self

    def messages(params, user)
      # return Utils.render_json({codeError: 11, message: "You are not the admin of the base"}, 403) unless user.admin_of_base?(params["base_id"])
      conversation = Conversation.find_by(id: params["conversation_id"])
      user = User.find_by(id: params["user_id"])
      messages = Message.where(user_id: user.id).where(conversation_id: conversation.id)

      return Utils.render_json({messages: messages}, 200)
    end

    def create_message(params, user)
      missing_fields = Utils.check_missing_fields(params, ["name"], "message")
      return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0


      conversation = Conversation.find_by(id: params["conversation_id"])
      user = User.find_by(id: params["user_id"])

      message = Message.find_or_create_by(user_id: user.id,conversation_id: conversation.id ,name: params["department"]["name"])

      return Utils.render_json({message: message}, 200)
    end

    def destroy_message(params, user)
      missing_fields = Utils.check_missing_fields(params, ["id"], "message")
      return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

      Message.where(id: params["message"]["id"]).destroy_all

      return Utils.render_json({message: "Message has been destoryed successfully"}, 200)
    end
  end

end

