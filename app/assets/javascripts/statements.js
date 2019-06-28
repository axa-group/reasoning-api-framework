// fix for select2 input width in Bootrap 4 layout: https://github.com/select2/select2/issues/3278
$.fn.select2.defaults.set( "width", "100%" );

// select2 config
$( document ).on('ready cocoon:after-insert shown.bs.modal', function(e, insertedItem) {
  
  $("select.select2").select2({
    tags: true, 
    tokenSeparators: [','],
    matcher: function(term, text) { return false } // never match search: allow for sub strings of existing tags
  });
  // mark entity cloud for deletion if no tags 
  $("select.select2").on( 'select2:close', function() {
    $(this).closest("td").find(".delete input").val(($(this).val() == ""));
  });

  $("select.select2").on('select2:open', function (e) {
    $('.select2-container--open .select2-dropdown--below').css('display','none');
  });

  // prevent form from submitting by hitting Enter 
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });

});
