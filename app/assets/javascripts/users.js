// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function checkEnableDailyReminder(enableDailyReminder) {
	var dailyReminder = $(".daily_reminder_timer .select-wrapper");

	if (typeof enableDailyReminder !== 'undefined') {
		if(enableDailyReminder.checked) {
			dailyReminder.show();
		} else {
			dailyReminder.hide();
		}
	}
}

$("#user_enable_daily_reminder").on("click", function() {
	checkEnableDailyReminder(this);
});

$(document).on("ready page:load", function() {
	checkEnableDailyReminder($("#user_enable_daily_reminder")[0]);
});


