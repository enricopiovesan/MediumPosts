avavlsanlsclass MessengerController < Messenger::MessengerController

  def webhook
    #logic here

    #Postback
    if fb_params.first_entry.callback.postback?
      value = params["entry"].first["messaging"].first["postback"]["payload"]
      puts case tag
      when "start"
        #start message here
        start()
      when "case-b"
        #logic here
        results()
      else
        #logic here
      end
    end

    render nothing: true, status: 200
  end

  def start
    buttons = Messenger::Templates::Buttons.new(
       text: 'Hi there, let’s get started! You\'re now talking to the super cool Wine Tasting bot. 🤖🍷😀',
       buttons: [
            Messenger::Elements::Button.new(
              type: 'postback',
              title: 'Book a Wine Tasting',
              value: 'book'
            ),
            Messenger::Elements::Button.new(
              type: 'postback',
              title: 'Chat with an Agent',
              value: 'agent'
            )
       ]
    )
    Messenger::Client.send(
      Messenger::Request.new(buttons,fb_params.first_entry.sender_id)
    )
  end

  def results
    tastings = #here the query
    #check if there are some results
    if tastings.length > 0

      #first message
      Messenger::Client.send(
              Messenger::Request.new(
                Messenger::Elements::Text.new(text: 'Great I found those wine tastings for you! 🍇🍷👫'), fb_params.first_entry.sender_id)
       )
    #create the Bubble elements array
      elements = []
      tastings.each do |tasting|
            item = Messenger::Elements::Bubble.new(
              title: title,
              subtitle: subtitle,
              image_url: image_url,
              buttons: [
                Messenger::Elements::Button.new(
                  type: 'postback',
                  title: 'More info',
                  value: value
                ),
                Messenger::Elements::Button.new(
                  type: 'web_url',
                  title: 'Book now',
                  value: url
                )
              ]
            )
            elements.push(item)
      end #end each
      #setup the template
      generic = Messenger::Templates::Generic.new(
            elements: elements
      )
      #send message
      Messenger::Client.send(
          Messenger::Request.new(generic,
          fb_params.first_entry.sender_id)
      )
    end #end if    
  end

end
