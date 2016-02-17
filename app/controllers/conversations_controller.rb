class ConversationsController < ApplicationController
   before_filter :authenticate_user!
   helper_method :mailbox, :conversation 
   
   def create
   	recipient_emails = conversation_params(:recipient).split(',')
   	recipient = User.where(:email recipient_emails).all
   	conversation = current_user.send_message(recipients,*conversation_params(:body, :subjec)).conversation
    redirect_to conversation_path(conversation)
   end 

   def reply
   	current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
   end   
   
   def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversation  	
   end 

   def untrash
   	conversation.untrash(current_user)
   	redirect_to :conversation
   end

   private

   def mailbox
    @mailbox ||= current_user.mailbox
   end

   def conversation
   	@conversation ||= mailbox.conversation.find(params[:id])
   end
    
   def conversation_params(*keys)
   	fetch_params(:message, *keys)
   end

   def message_params(*keys)
    fetch_params(:message, *keys)
   end
   
   def fetch_params(key, *subkeys)
    params[key].instance_eval do
     case subkeys.size
     when 0 then self
     when 1 then self[subkeys.first]
     else subkeys.map{|k| self[k] }
     end
    end
  end
end
