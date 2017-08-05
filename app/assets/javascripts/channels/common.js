App.chat = App.cable.subscriptions.create("CommonChannel", {
    connected: function() {
        // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
        // Called when the subscription has been terminated by the server
    },

    received: function(data) {
        if (window.location.pathname == '/chats') {
            $('#common_messages').prepend(data['message']);
        } else if (window.location.pathname == '/profiles'){
            $('#common_messages').prepend(data['message']);
            $("#common_messages li:last-child").remove()
        }

    },
});