# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();

  $('.comment-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#comment-question-' + question_id).show();


  $('.subscribe-question-link').click (e) ->
    question_id = $(this).data('questionId');
    $('.subscription').html('<small><a class="unscribe-question-link" data-question-id="' + question_id + '" data-remote="true" rel="nofollow" data-method="delete" href="/questions/' + question_id + '/unscribe">Unscribe</a></small>');
    $('.unscribe-question-link').click (e) ->
      question_id = $(this).data('questionId');
      $('.subscription').html('<small><a class="subscribe-question-link" data-question-id="' + question_id + '" data-remote="true" rel="nofollow" data-method="post" href="/questions/' + question_id + '/subscribe">Subscribe</a></small>').stop(true);

  $('.unscribe-question-link').click (e) ->
    question_id = $(this).data('questionId');
    $('.subscription').html('<small><a class="subscribe-question-link" data-question-id="' + question_id + '" data-remote="true" rel="nofollow" data-method="post" href="/questions/' + question_id + '/subscribe">Subscribe</a></small>').stop(true);
    $('.subscribe-question-link').click (e) ->
      question_id = $(this).data('questionId');
      $('.subscription').html('<small><a class="unscribe-question-link" data-question-id="' + question_id + '" data-remote="true" rel="nofollow" data-method="delete" href="/questions/' + question_id + '/unscribe">Unscribe</a></small>');


  $('.vote_up_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden').addClass('vote_cancel_question-link');
  
  $('.vote_down_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.hidden').toggleClass('hidden').addClass('vote_cancel_question-link');
  
  $('.vote_cancel_question-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-question-' + vote.id).html('Rating: ' + vote.votes_count);
    $('#cancel_vote-' + vote.id + '.vote_cancel_question-link').toggleClass('vote_cancel_question-link').addClass('hidden');


  PrivatePub.subscribe '/questions', (data, channel) ->
    question = $.parseJSON(data['question']);
    $('.all-questions').append('<h4><a href="/questions/' + question.id + '">' + question.title + '</a></h4>' + '<span>Rating: ' + '</span>' + '<br><small>When: ' + '"' + question.created_at + '"' + '</small>' + '<br><small>Who: ' + '</small>' + '<br><small><a rel="nofollow" data-method="delete" href="/questions/' + question.id + '">Delete</a></small>');


$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
