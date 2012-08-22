

window.app = {}
window.app.SAVE_NOTE_INTERVAL =  15000

($ document).ready -> 
  
  # Set up datepickers
  $('.datepicker').datepicker dateFormat: 'D, dd M yy'
 
  # Set up showdown converters
  $('.showdown').each -> Util.convert_markdown ($ this)
   
  # Auto save
  $note_body = ($ '#note_body')
  if $note_body.length > 0
    
    original_value = $note_body.val()
    previous_value = original_value
    
    save_note = ->
      data = {} 
      $form = ($ 'form.edit_note')
      data_array = $form.serializeArray()
      $.each data_array, ((i, obj) -> data[obj.name] = obj.value)

      $.ajax
        type: 'POST'
        url: $form.attr('action')
        data: data
        dataType: 'json'
        success: (resp) => 
          Util.show_success "saved note"
        error: (resp) => 
          console.log resp
    
    check_and_save = ->
      if $note_body.val() != previous_value
        previous_value = $note_body.val()
        save_note()
      
    setInterval check_and_save, window.app.SAVE_NOTE_INTERVAL
    
    ($ '#reset_note_body').click ->
      return unless (confirm "Really reset to note when page was opened?")
      $note_body.val original_value


window.Util = (->
  show_success: (msg) ->
    ($ '#notice').html(msg).fadeIn()
    setTimeout (-> ($ '#notice').fadeOut()), 2000
    
  convert_markdown: ($el) ->
    @converter ||= new Showdown.converter()
    $el.html @converter.makeHtml $el.html()

)()
  