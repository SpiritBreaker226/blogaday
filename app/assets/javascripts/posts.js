// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ready page:load", function() {
	$("#search-form").submit(function(e) {
		e.preventDefault();

		var searchValue = $('#search').val();

		$.getScript('/posts?search=' + searchValue);
	});
});