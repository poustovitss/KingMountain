App.notifications = App.cable.subscriptions.create("PersonalMessagesChannel", {
    connected: function() {
        // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
        // Called when the subscription has been terminated by the server
    },

    received: function(data) {


            $.ajax({
                url: '/prepend_personal_message',
                data: {id: data.message_id},
                type: 'GET'
            });

            var unread_counts = $( "span#unread_messages_count" );
            var count_str = unread_counts.text();
            var count_num =  parseInt(count_str) + 1;
            unread_counts.html(count_num);
            var messages_box = $("#menu1");
            if (messages_box.children('li').length == 6){
                $("#menu1 li:last-child").prev().remove();
            }



    }
});