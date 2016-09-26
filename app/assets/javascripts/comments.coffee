# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-comment-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    comment_id = $(this).data('commentId');
    $('form#edit-comment-' + comment_id).show("slow");
  

  $('form.new_comment').bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText);
    $('.comments-' + comment.commentable_type.toLowerCase() + '-' + comment.commentable_id).append('<i>' + comment.body + '</i>');
    $('form.new_comment').hide();
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.comment-errors').append(value)


  $('form.edit_comment').bind 'ajax:success', (e, data, status, xhr) ->
    comment = $.parseJSON(xhr.responseText);
    $('.comment-' + comment.id).replaceWith('<i>' + comment.body + '</i>');


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
