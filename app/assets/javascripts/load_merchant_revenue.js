function loadMerchantRevenue(){
  $('.merchants-table').delegate('#view-merchant-amounts', 'click', function() {
    var $button = $(this).closest('.button')
    $button.replaceWith(`<div class="ui active centered inline loader" id="merchants-loader"></div>`)

    var merchantId = $(this).attr('data-id')
    var merchantRow =$(this)

    $.ajax({
      type:    "GET",
      url:     "/api/v1/merchants/" + merchantId + "/revenue",
      success: function(rev_hash) {
        var formatted_revenue = '$' + rev_hash.revenue.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
        $('#merchants-loader').replaceWith(`<p>${formatted_revenue}</p>`)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
})

}
