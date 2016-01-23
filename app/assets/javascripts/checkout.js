$(document).ready(function(){
  console.log("The checkout.js file has loaded.")
    bindClickListener();
});

var bindClickListener = function() {
  $('.remove-from-cart').click(function(e){
    e.preventDefault();
    // console.log("Remove item click detected as: "+this);
    row_to_remove = this;
    captured_data = $(this).parent().serialize();
    // console.log("Collected form data is: "+captured_data);
  $.ajax({
      method: "DELETE",
      url: '/cart',
      data: captured_data
      // dataType: "JSON"
    }).done(function(response){
      console.log("The item has been deleted from your cart & sent back a response.");
      // $(this).closest('.item-row').addClass('hide');
      $(row_to_remove).closest('.item-row').fadeOut(500);
      var cart_price = parseInt($('.item-total').text());
      console.log("The original price was "+cart_price);
      console.log("The amount to deduct is "+response.price_deducted);
    });
  });
}
