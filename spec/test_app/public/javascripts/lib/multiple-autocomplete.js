$.fn.multipleAutocomplete = function(options) {

  var values = options.source;

  var split = function(val) {
    return val.split(/\s*,\s*/);
  };

  var extractLast = function(term) {
    return split(term).pop();
  };

  this.autocomplete({
    minLength: 0,
    source: function(request, response) {
      // delegate back to autocomplete, but extract the last term
      response($.ui.autocomplete.filter(values, extractLast(request.term)));
    },
    focus: function() {
      // prevent value inserted on focus
      return false;
    },
    select: function(event, ui) {
      var terms = split( this.value );
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push( ui.item.value );
      // add placeholder to get the comma-and-space at the end
      terms.push("");
      this.value = terms.join(", ");
      return false;
    },
    open: function(event, ui) {
      $(this).autocomplete('widget').width(500);
    }
  });

};
