if (window.location.pathname.indexOf('/chat_rooms/') >= 0){
    var chat_room_id = window.location.pathname.split("/")[2];
    App.interaction = App.cable.subscriptions.create(
        {
            channel: "ChatRoomChannel",
            chat_room_id: chat_room_id
        },
        {
            connected: function() {

            },
            disconnected: function() {

            },
            received: function(data) {
                return $('.messages').prepend(data['message']);
            }
        }
    );
}
