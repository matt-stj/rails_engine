function loadMerchants(){
  $('#view-merchants').on('click', function(){
    $('#top-merchants').append(`<div class="ui active centered inline loader" id="merchants-loader"></div>`)

    var requestAction = `GET /api/v1/merchants/most_revenue?quantity=5`
    var activeRecordQuery = 'Item.sort_by(invoices.successful.joins(:invoice_items).sum("quantity * unit_price")).reverse.first(quantity.to_i)'
    var pageAction = new currentProcess(requestAction, activeRecordQuery)

    var ajaxTime= new Date().getTime();
    $.ajax({
      type:    "GET",
      url:     "/api/v1/merchants/most_revenue?quantity=5",
      success: function(merchants) {
        var totalTime = new Date().getTime()-ajaxTime;
        pageAction.time = totalTime

        $('#merchants-loader').remove()

        $.each(merchants, function(index, merchant) {
          renderMerchant(merchant)
        })

        $('#view-merchants').remove()
        $('.merchant-revenue-column').show()

        renderProcess(pageAction)
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  })
}
