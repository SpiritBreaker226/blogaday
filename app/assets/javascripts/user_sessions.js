// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ready page:load", function() {
	$(".button-collapse").sideNav();

	if (notice != undefined) {
		display_materialize_toats(notice['message'], notice['className']);

		notice = undefined;
	}
});

function display_materialize_toats (displayText, className) {
	Materialize.toast(displayText, 5000, className);
}
