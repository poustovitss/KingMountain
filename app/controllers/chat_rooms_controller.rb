class ChatRoomsController < ApplicationController
  layout 'application_profile'
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy]

  # GET /chat_rooms
  # GET /chat_rooms.json
  def index
    @chat_rooms = current_user.chat_rooms
  end

  # GET /chat_rooms/1
  # GET /chat_rooms/1.json
  def show
    @other_user = User.find(params[:other_user])
    @chat_room.messages.each do |message|
      message.unread_messages.destroy_all
    end
    @messages = @chat_room.messages.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
  end

  # GET /chat_rooms/new
  def new
    @chat_room = ChatRoom.new
  end

  # GET /chat_rooms/1/edit
  def edit
  end

  # POST /chat_rooms
  # POST /chat_rooms.json
  def create
    @other_user = User.find(params[:other_user])
    if @other_user == current_user
      redirect_to chat_rooms_path, notice: 'Здесь нельзя с самим собой общаться....'
    else
      @chat_room = ChatRoom.new()

      @chat_room = find_chat(@other_user) || ChatRoom.new()
      if !@chat_room.persisted?
        @chat_room.save
        @chat_room.subscriptions.create(user_id: current_user.id)
        @chat_room.subscriptions.create(user_id: @other_user.id)
      end
      redirect_to chat_room_path(@chat_room,  :other_user => @other_user.id)
    end

  end

  # PATCH/PUT /chat_rooms/1
  # PATCH/PUT /chat_rooms/1.json
  def update
    respond_to do |format|
      if @chat_room.update(chat_room_params)
        format.html { redirect_to @chat_room, notice: 'Chat room was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat_room }
      else
        format.html { render :edit }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_rooms/1
  # DELETE /chat_rooms/1.json
  def destroy
    @chat_room.messages.destroy_all
    respond_to do |format|
      format.html { redirect_to chat_rooms_url, notice: 'Chat room was successfully cleared.' }
      format.json { head :no_content }
    end
  end

  def prepend_personal_message
    @message = Message.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_room_params
      params.require(:chat_room).permit(:title)
    end

    def find_chat(second_user)
      chats = current_user.chat_rooms
      chats.each do |chat|
        chat.subscriptions.each do |s|
          if s.user_id == second_user.id
            return chat
          end
        end
      end
      nil
    end
end
