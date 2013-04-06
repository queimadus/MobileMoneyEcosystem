/*
  Bootstrap - File Input
  ======================

  This is meant to convert all file input tags into a set of elements that displays consistently in all browsers.

  Converts all
  <input type="file">
  into Bootstrap buttons
  <a class="btn">Browse</a>

*/
function bind_input() {

$('*:not(".file-input-wrapper") > input[type=file]').each(function(i,elem){

  // Maybe some fields don't need to be standardized.
  if (typeof $(this).attr('data-bfi-disabled') != 'undefined') {
    return;
  }

  // Set the word to be displayed on the button
  var buttonWord = 'Browse';

  if (typeof $(this).attr('title') != 'undefined') {
    buttonWord = $(this).attr('title');
  }

  // Start by getting the HTML of the input element.
  // Thanks for the tip http://stackoverflow.com/a/1299069
  var input = $('<div>').append( $(elem).eq(0).clone() ).html();

  // Now we're going to replace that input field with a Bootstrap button.
  // The input will actually still be there, it will just be float above and transparent (done with the CSS).
  $(elem).replaceWith('<a class="file-input-wrapper ">'+'<span id="buttonword">'+buttonWord+'</span>'+input+'</a>');
})
// After we have found all of the file inputs let's apply a listener for tracking the mouse movement.
// This is important because the in order to give the illusion that this is a button in FF we actually need to move the button from the file input under the cursor. Ugh.
.promise().done( function(){

  // As the cursor moves over our new Bootstrap button we need to adjust the position of the invisible file input Browse button to be under the cursor.
  // This gives us the pointer cursor that FF denies us
  $('.file-input-wrapper').mousemove(function(cursor) {

    var input, wrapper,
      wrapperX, wrapperY,
      inputWidth, inputHeight,
      cursorX, cursorY;

    // This wrapper element (the button surround this file input)
    wrapper = $(this);
    // The invisible file input element
    input = wrapper.find("input");
    // The left-most position of the wrapper
    wrapperX = wrapper.offset().left;
    // The top-most position of the wrapper
    wrapperY = wrapper.offset().top;
    // The with of the browsers input field
    inputWidth= input.width();
    // The height of the browsers input field
    inputHeight= input.height();
    //The position of the cursor in the wrapper
    cursorX = cursor.pageX;
    cursorY = cursor.pageY;

    //The positions we are to move the invisible file input
    // The 20 at the end is an arbitrary number of pixels that we can shift the input such that cursor is not pointing at the end of the Browse button but somewhere nearer the middle
    moveInputX = cursorX - wrapperX - inputWidth + 20;
    // Slides the invisible input Browse button to be positioned middle under the cursor
    moveInputY = cursorY- wrapperY - (inputHeight/2);

    // Apply the positioning styles to actually move the invisible file input
    input.css({
      left:moveInputX,
      top:moveInputY
    });
  });

  $('.file-input-wrapper input[type=file]').change(function(){

    // Remove any previous file names
    //$(this).parent().next().has('file-input-name').remove();
    //$(this).parent().after('<span class="file-input-name">'+$(this).val()+'</span>');

    $(this).parent().find("#buttonword").text($(this).val().split("\\").slice(-1)[0]);

  });

  

});

// Add the styles before the first stylesheet
// This ensures they can be easily overridden with developer styles


}