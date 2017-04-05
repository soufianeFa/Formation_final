class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :participations
  has_many :messages

    class << self

      def conversations(params, user)
        # return Utils.render_json({codeError: 11, message: "You are not the admin of the base"}, 403) unless user.admin_of_base?(params["base_id"])
        user = User.find_by(id: params["user_id"])
        conversations = Conversation.where(user_id: user.id)

        return Utils.render_json({conversations: conversations}, 200)
      end

      def create_conversation(params, user)
        missing_fields = Utils.check_missing_fields(params, ["subject"], "conversation")
        return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

        user = User.find_by(id: params["user_id"])

        conversation = Conversation.find_or_create_by(user_id: user.id, name: params["conversation"]["subject"])

        return Utils.render_json({conversation: conversation}, 200)
      end

      def destroy_conversation(params, user)
        missing_fields = Utils.check_missing_fields(params, ["id"], "conversation")
        return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

        Conversation.where(id: params["conversation"]["id"]).destroy_all

        return Utils.render_json({message: "Conversation has been destoryed successfully"}, 200)
      end
    end
end
