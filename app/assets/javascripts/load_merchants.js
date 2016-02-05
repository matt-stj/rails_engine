function loadMerchants(){
  $.ajax({
    type:    "GET",
    url:     "/api/v1/merchants/most_revenue?quantity=5",
    success: function(merchants) {
      $.each(merchants, function(index, merchant) {
        renderMerchant(merchant)
      })
    },
    error: function(xhr) {
      console.log(xhr.responseText)
    }
  })
}
