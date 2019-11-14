module ApplicationHelper
  # form auth token
  def auth_token
    "<input type=\"hidden\"
            name=\"authenticity_token\"
            value='#{form_authenticity_token}'
    >".html_safe
  end

  # Format Lyrics
  def ugly_lyrics(lyrics)
    formatted_lyrics = ""
    lyrics.lines.each do |line|
      # h properly escapes the user input (avoid HTML injection attacks).
      formatted_lyrics << "&#9835; #{h(line)}"
    end
    
    # Mark the produced HTML as safe for insertion (otherwise your <pre> tag 
    # will get escaped when you insert it into the template).
    "<pre id='show-lyrics'>#{formatted_lyrics}</pre>".html_safe
  end
end
