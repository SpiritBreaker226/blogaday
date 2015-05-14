// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function checkEnableDailyReminder(enableDailyReminder) {
	var dailyReminder = $("#user_daily_reminder_4i");

	if(enableDailyReminder.checked) {
		dailyReminder.show();
	} else {
		dailyReminder.hide();
	}	
}

$("#user_enable_daily_reminder").on("click", function() {
	checkEnableDailyReminder(this);
});

$(document).on("ready page:load", function() {
	checkEnableDailyReminder($("#user_enable_daily_reminder")[0]);

	$('#user_daily_reminder_4i').material_select();
});


