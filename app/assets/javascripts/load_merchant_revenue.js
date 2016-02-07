function loadMerchantRevenue(){
  $('.merchants-table').delegate('#view-merchant-amounts', 'click', function() {
    var $button = $(this).closest('.button')
    $button.replaceWith(`<div class="ui active centered inline loader" id="merchants-loader"></div>`)

    var merchantId = $(this).attr('data-id')
    var merchantRow =$(this)

    var requestAction = `GET /api/v1/merchants/${merchantId}/revenue`
    var activeRecordQuery = 'invoices.successful.joins(:invoice_items).sum("quantity * unit_price")'
    var pageAction = new currentProcess(requestAction, activeRecordQuery)

    var ajaxTime= new Date().getTime();

    $.ajax({
      type:    `GET`,
      url:     `/api/v1/merchants/${merchantId}/revenue`,
      success: function(rev_hash) {
        var totalTime = new Date().getTime()-ajaxTime;
        pageAction.time = totalTime

        var formatted_revenue = '$' + rev_hash.revenue.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
        $('#merchants-loader').replaceWith(`<p>${formatted_revenue}</p>`)

        $('#processes').children().first().remove()
        renderProcess(pageAction)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
})

}
