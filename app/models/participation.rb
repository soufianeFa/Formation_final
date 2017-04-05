class Participation < ActiveRecord::Base
  belongs_to :conversation
  has_and_belongs_to_many :users

  class << self

    def participations(params, user)
      # return Utils.render_json({codeError: 11, message: "You are not the admin of the base"}, 403) unless user.admin_of_base?(params["base_id"])
      conversation = Conversation.find_by(id: params["conversation_id"])
      participations = Participation.where(conversation_id: conversation.id)

      return Utils.render_json({participations: participations}, 200)
    end

    def create_participation(params, user)
      missing_fields = Utils.check_missing_fields(params, ["name"], "participation")
      return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

      # return Utils.render_json({codeError: 11, message: "You are not the admin of the base"}, 403) unless user.admin_of_base?(params["base"]["base_id"])

      conversation = Conversation.find_by(id: params["conversation"]["conversation_id"])

      participation = Participation.find_or_create_by(conversation_id: Conversation.id, name: params["participation"]["name"])

      return Utils.render_json({participation: participation}, 200)
    end

    def destroy_participation(params, user)
      missing_fields = Utils.check_missing_fields(params, ["id"], "participation")
      return Utils.render_json({codeError: 2, message: "Missing required fields", missing_fileds: missing_fields}, 400) if missing_fields.size > 0

      # return Utils.render_json({codeError: 11, message: "You are not the admin of the base"}, 403) unless user.admin_of_base?(params["base"]["base_id"])

      Participation.where(id: params["participation"]["id"]).destroy_all

      return Utils.render_json({message: "Participation has been destoryed successfully"}, 200)
    end
  end

end
