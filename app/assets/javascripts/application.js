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
//= require jquery_nested_form
//= require jquery-fileupload
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


var cfg = {
    formId: '#new-housefile-fields',
    tableId: '#housefile-table',
    inputFieldClassSelector: '.field',
    getTBodySelector: function() {
        return this.tableId + ' tbody';
    }
};
var cfg2 = {
    formId: '#new-agent-fields',
    tableId: '#agent-table',
    inputFieldClassSelector: '.field',
    getTBodySelector: function() {
        return this.tableId + ' tbody';
    }
};




function select_agent_fields() {
	$('#new-agent-fields').modal('show');
}

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}
 
function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regex = new RegExp("new_" + association, "g");
    $(link).parent().after(content.replace(regex, new_id));
    jQuery('#new-housefile-fields').modal('show');
}

var housefileFieldsUI = {
    init: function() {
        $('#addButton').on('click', function() {
            formHandler.appendFields();
            formHandler.hideForm();
        });
        $('#cancelButton').on('click', function() {
            formHandler.hideForm();
        });
        $('#closeButton').on('click', function() {
            formHandler.hideForm();
        });
    }
};

var selectFieldsUI = {
    init: function() {
        $('#addButton').on('click', function() {
            selectformHandler.appendFields();
            selectformHandler.hideForm();
        });
        $('#cancelButton').on('click', function() {
            selectformHandler.hideForm();
        });
        $('#closeButton').on('click', function() {
            selectformHandler.hideForm();
        });
    }
};


var formHandler = {
    // Public method for adding a new row to the table.
    appendFields: function() {
        // Get a handle on all the input fields in the form and detach them from the DOM (we will attach them later).
        var inputFields = $(cfg.formId + ' ' + cfg.inputFieldClassSelector);
        inputFields.detach();
 
        // Build the row and add it to the end of the table.
        rowBuilder.addRow(cfg.getTBodySelector(), inputFields);
 
        // Add the "Remove" link to the last cell.
        rowBuilder.link.clone().appendTo($('tr:last td:last'));
    },
 
    // Public method for hiding the data entry fields.
    hideForm: function() {
        $(cfg.formId).modal('hide');
    }
};

var selectformHandler = {
    appendFields: function() {
        var inputFields = $('#agent_attributes_name');
		inputFields.html($('input:radio:checked').parent('label').text());
    },
 
    // Public method for hiding the data entry fields.
    hideForm: function() {
        $(cfg2.formId).modal('hide');
    }
};


// Provides functionality for building the HTML that represents a new <TR> for the Pilots table.
var rowBuilder = function() {
    // Private property that define the default <TR> element text.
    var row = $('<tr>', { class: 'fields' });
 
    // Public property that describes the "Remove" link.
    var link = $('<a>', {
        href: '#',
        onclick: 'remove_fields(this); return false;',
        title: 'Delete this File.'
    }).append('Remove');
 
    // A private method for building a <TR> w/the required data.
    var buildRow = function(fields) {
        var newRow = row.clone();
 
        $(fields).map(function() {
            $(this).removeAttr('class');
            var td = $('<td/>').append($(this));
            td.appendTo(newRow);
        });
 
        return newRow;
    };
 
    // A public method for building a row and attaching it to the end of a <TBODY> element.
    var attachRow = function(tableBody, fields) {
        var row = buildRow(fields);
        $(row).appendTo($(tableBody));
    };
 
    // Only expose public methods/properties.
    return {
        addRow: attachRow,
        link: link
    };
}();