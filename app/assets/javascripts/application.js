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
//= require jquery.cookie
//= require bootstrap.min
//= require humane

function toggleCheckboxes(control) {
    var checked = control.checked;
    $('table input[type=checkbox][value]').each(function() {
        this.checked = checked;
    });
}
$(function() {
    $("#item_name").on('keyup focus', function(e) {
        document.getElementById('plural').innerHTML =  e.target.value.split(';').map(function(value) {
            value = value.trim();
            if (value == "") {
                return "";
            }
            return ion.pluralize(value, 1) + " / " + ion.pluralize(value, 2);
        }).join('<br>');
    });
    $("#searchForm").on('submit', function() {
        $.cookie('search', $('#searchSrc').val());
    });
    $("#mainForm").on('submit', function() {
       $('#searchDest').val($('#searchSrc').val());
    }); 
    $('#clear-search').on('click', function() {
       $('#searchSrc').val("");
       $('#searchForm').submit();
    });
});
