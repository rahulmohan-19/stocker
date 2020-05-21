App.messages = App.cable.subscriptions.create('CommentsChannel', {  
  received: function(data) {
    console.log('received data', data);
    lengthOfUrl = window.location.pathname.length 
    if ( window.location.pathname.lastIndexOf('/') == lengthOfUrl -1 ) //dirty fix to handle if url has / at the end
    {
      current_comment_path = '/posts/' + data.post_id + '/';
    } else {
      current_comment_path = '/posts/' + data.post_id;
    }
    if (window.location.pathname == current_comment_path)
    {
      $('#comments').append(this.renderMessage(data));
    }
    return 
  },

  renderMessage: function(data) {
    return "<p><em>New!</em>&nbsp;&nbsp;"+ data.email + "<span><small>&nbsp;says:&nbsp;</small>" +  data.message + "</span></p>";
  }
});
