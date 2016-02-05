function renderMerchant(merchant) {
  $('#top-merchants').append(`<tr><td>${merchant.name}</td><td class='merchant-revenue-column' style="display: none'"><button data-id=${merchant.id} class="mini ui button floated right blue" id="view-merchant-amounts" style="float: right;">$</button></td></tr>`)
}
