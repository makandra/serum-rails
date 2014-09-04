// Javascript snippets to improve the UI look and feel. 
// origin: RM


// CSRF token to ajax request //////////////////////////////////////////////////////////////////////////////////////////

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

// Utility methods /////////////////////////////////////////////////////////////////////////////////////////////////////

$.fn.setVisibility = function(show) {
  this[show ? 'show' : 'hide']();
};

RegExp.escape = function(str) {
  return String(str).replace(/([.*+?^=!:${}()|[\]\/\\])/g, '\\$1');
};

// Unobstrusive hook ///////////////////////////////////////////////////////////////////////////////////////////////////

$.unobstrusive = function(callback) {
  $(document).bind('activate-unobstrusive-javascript', function(event, root) {
    $(root).each(callback);
  });
}

$.fn.activateUnobstrusiveJavascript = function() {
  this.each(function() {
    $(document).trigger('activate-unobstrusive-javascript', this);
  });
}

$(function() {
  $(document).activateUnobstrusiveJavascript();
});


// Date picker and datetime picker /////////////////////////////////////////////////////////////////////////////////////

$.unobstrusive(function() {
  $('.date_picker').datepicker();
});

$.unobstrusive(function() {
  $('.datetime_picker').datetimepicker({
    timeText: 'Uhrzeit',
    hourText: 'Stunde',
    minuteText: 'Minute',
    stepMinute: 5,
    hour: 12,
    currentText: 'jetzt'
  });
});


// HTML5 autofocus emulation for legacy browsers ///////////////////////////////////////////////////////////////////////

var Autofocus = {

  supported: function() {
    return 'autofocus' in document.createElement('input');
  },

  fake: function() {
    $('[autofocus]').focus();
  },

  extend: function() {
    Autofocus.supported() || Autofocus.fake();
  }

};

$.unobstrusive(Autofocus.extend);


// Combo box control (does not work in IE) /////////////////////////////////////////////////////////////////////////////

$.fn.comboBox = function() {
  $(this).each(function() {
    $(this).change(function() {
      var element = $(this);
      if (element.val() == element.attr('data-combo_box_new_choice')) {
        var newValue = prompt("Eintrag hinzufügen:", "");
        if (newValue) {
          var newOption = $('<option></option>').attr('value', newValue).text(newValue);
          element.find('option:last').before(newOption);
          element.val(newValue);
        } else {
          element.val('');
        }
      }
    });
  });
};

$.unobstrusive(function() {
  $(this).find('.combo_box').comboBox();
});


// Tag picker //////////////////////////////////////////////////////////////////////////////////////////////////////////

$.fn.tagPicker = function(action, arg) {
  if (action == 'add') {
    var tag = arg;
    $(this).each(function() {
      var value = $(this).val();
      var inclusionPattern = new RegExp('(^| )' + RegExp.escape(tag) + '( |$)', 'i');
      if (!value.match(inclusionPattern)) {
        if (value != '') {
          value += ', '
        }
        value += tag;
        $(this).val(value);
      }
    });
  }
};

// Auto-growing text areas /////////////////////////////////////////////////////////////////////////////////////////////

$.unobstrusive(function() {
  $(this).find('textarea').elastic();
});


// Visibility toggling in forms ////////////////////////////////////////////////////////////////////////////////////////

$.unobstrusive(function() {
    function selectVisibility() {
      var selector = $($(this).attr('data-selects-visibility'));
      var value = $(this).val();
      if ($(this).is('input[type="checkbox"]')) {
        if ($(this).is(':checked')) {
          value = '_checked';
        } else {
          value = '_unchecked';
        }
      } else if ( value == '' ) {
        value = '_blank';
      }
      selector.filter('[data-show-for]:not([data-show-for~="' + value + '"])').hide();
      selector.filter('[data-hide-for~="' + value + '"]').hide();
      selector.filter('[data-hide-for]:not([data-hide-for~="' + value + '"])').show();
      selector.filter('[data-show-for~="' + value + '"]').show();
    }

    $(this).find('[data-selects-visibility]').change(selectVisibility);
    $(this).find('select[data-selects-visibility]').each(selectVisibility);
    $(this).find('input[data-selects-visibility][type="checkbox"]').each(selectVisibility);
    $(this).find('input[data-selects-visibility][type="radio"]:checked').each(selectVisibility);
});


// Tooltips ////////////////////////////////////////////////////////////////////////////////////////////////////////////

$.unobstrusive(function() {
  $(this).find('[title]').not('[data-no-tooltip]').poshytip({
    className: 'tip-deepgray',
    showTimeout: 0,
    hideTimeout: 0,
    fade: false,
    slide: false,
    alignTo: 'target',
    alignX: 'center',
    alignY: 'top',
    offsetY: 8,
    offsetX: 0
  });
});

