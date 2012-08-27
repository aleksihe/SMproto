// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui-timepicker-addon.js
//= require jquery-ui-sliderAccess.js
//= require_tree .
//= require cocoon


/*datepicker*/
$(function() {
	$('.ui-datetime-picker').datetimepicker({
		timeFormat: 'hh:mm',
		stepHour: 1,
		stepMinute: 1
	});
	
	$.datepicker.regional['fi'] = {clearText: 'Tyhjennä', clearStatus: '',
		closeText: 'Sulje', closeStatus: '',
		prevText: '<Edellinen', prevStatus: '',
		nextText: 'Seuraava>', nextStatus: '',
		currentText: 'Nykyinen', currentStatus: '',
		monthNames: ['Tammikuu','Helmikuu','Maaliskuu','Huhtikuu','Toukokuu','Kesäkuu',
		'Heinäkuu','Elokuu','Syyskuu','Lokakuu','Marraskuu','Joulukuu'],
		monthNamesShort: ['Tammi','Helmi','Maalis','Huhti','Touko','Kesä',
		'Heinä','Elo','Syys','Loka','Marras','Joulu'],
		monthStatus: '', yearStatus: '',
		weekHeader: 'Vko', weekStatus: '',
		dayNames: ['Sunnuntai','Maanantai','Tiistai','Keskiviikko','Torstai','Perjantai','Lauantai'],
		dayNamesShort: ['Su','Ma','Ti','Ke','To','Pe','La'],
		dayNamesMin: ['Su','Ma','Ti','Ke','To','Pe','La'],
		dayStatus: '', dateStatus: '',
		dateFormat: 'dd/mm/yy', firstDay: 1, 
		initStatus: 'Valitse päivä', isRTL: false};
	$.datepicker.setDefaults($.datepicker.regional['fi']);
	
	$.timepicker.regional['fi'] = {
	timeOnlyTitle: 'Valitse aika',
	timeText: 'Aika',
	hourText: 'Tunti',
	minuteText: 'Мinuutti',
	secondText: 'Sekunti',
	millisecText: 'Millisekunti',
	currentText: 'Nyt',
	closeText: 'Valmis',
	ampm: false
	};
	$.timepicker.setDefaults($.timepicker.regional['fi']);
	
	
});



