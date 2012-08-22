

window.app = {}
window.app.SAVE_NOTE_INTERVAL =  5000

($ document).ready -> 
  
  # Set up datepickers
  $('.datepicker').datepicker dateFormat: 'D, dd M yy'
 
  # Set up showdown converters
  $('.showdown').each -> Util.convert_markdown ($ this)
   
  # Fade initial notice (if there was one)
  Util.hide_notice()
  
  # Note editing form; Auto save and update preview
  if ($ '.edit_note').length > 0
    $note_body = ($ '#note_body')
    
    original_value = $note_body.val()
    previous_value = original_value
    
    save_note = ->
      previous_value = $note_body.val()
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
          update_preview()
        error: (resp) => 
          console.log resp
    
    update_preview = ->
      preview_html = Util.convert_raw_markdown $note_body.val()
      ($ '.preview').html preview_html
      
    check_and_save = ->
      if $note_body.val() != previous_value
        save_note()
      
    setInterval check_and_save, window.app.SAVE_NOTE_INTERVAL
    
    ($ '#save_now').click -> save_note() && false
    
    ($ '#reset_note_body').click ->
      return unless (confirm "Really reset note to when page was opened?")
      $note_body.val original_value
      return false

window.Util = (->
  show_success: (msg) ->
    ($ '#notice').html(msg).fadeIn()
    Util.hide_notice()
  
  hide_notice: -> 
    setTimeout (-> ($ '#notice').fadeOut()), 2000
  
  convert_raw_markdown: (markdown) ->
    @converter ||= new Showdown.converter()
    @converter.makeHtml markdown
  
  convert_markdown: ($el) ->
    $el.html (Util.convert_raw_markdown $el.html())

)()
  