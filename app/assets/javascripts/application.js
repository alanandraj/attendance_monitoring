// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function check_file() {
    var file = document.getElementById('file_name').value;
    if(file == null || file == "") {
        alert("Please choose the file");
        return false;
    }

    var ext = file.substring(file.lastIndexOf('.') + 1).toLowerCase();

    if(ext != 'csv') {
        alert("Please choose only csv file type");
        return false;
    }

}

/* validate dates */
function validate_date() {
    var from_date = document.getElementById("from-date").value;
    var to_date = document.getElementById("to-date").value;

    if(from_date == null || from_date =="" || to_date == null || to_date =="") {
        alert("Select the date");
        return false;
    }

    if(from_date > to_date) {
        alert("Invalid date selection");
        return false;
    }

}




