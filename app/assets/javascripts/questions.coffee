# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();


  $('.vote_up_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).replaceWith('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden');
    $('#cancel_vote-' + vote.id).addClass('vote_cancel_question-link');

  
  $('.vote_down_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).replaceWith('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden');
    $('#cancel_vote-' + vote.id).addClass('vote_cancel_question-link');

  
  $('.vote_cancel_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).replaceWith('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.vote_cancel_question-link').toggleClass('vote_cancel_question-link');
    $('#cancel_vote-' + vote.id).addClass('hidden');


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
