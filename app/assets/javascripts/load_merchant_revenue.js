function loadMerchantRevenue(){
  $('#view-merchant-amounts').on('click', function(){
    $('#view-merchant-amounts').replace(`<div class="ui active inline loader" id="merchants-loader"></div>`)

    $.ajax({
      type:    "GET",
      url:     "/api/v1/merchants/most_revenue?quantity=5",
      success: function(merchants) {
        $('#merchants-loader').remove()

        $.each(merchants, function(index, merchant) {
          renderMerchant(merchant)
        })

        $('#view-merchants').replaceWith(`<button class="ui button floated right blue" id="view-merchant-amounts" style="float: right;">View Total $ Amt.</button>`)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}
