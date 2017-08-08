class ChatsController < InheritedResources::Base

  layout 'application_profile'

  def index
    @common_chat_messages = CommonChatMessage.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end

  private

    def chat_params
      params.require(:chat).permit(:name)
    end
end

