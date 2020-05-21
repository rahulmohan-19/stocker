//= require action_cable
//= require_self

App.messages = App.cable.subscriptions.create('NotificationsChannel', {  
  received: function(data) {
    console.log('received data', data);
    var newPostUrl= "/posts/" + data.post_id ;
    $(".toast-body a").attr("href", newPostUrl);
    $(".toast-body a").text('You have a new post!')
    return 
  }


});

