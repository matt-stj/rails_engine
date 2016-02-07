function renderProcess(processObject){
  $('#processes').append("<tr><td class='process-name'>"
    + processObject.endpoint
    + "</td><td class='active-record-column'>"
    + processObject.activeRecordQuery
    + "</td><td class='process-time-column'>"
    + processObject.time
    + "</td></tr>"
  )
}
