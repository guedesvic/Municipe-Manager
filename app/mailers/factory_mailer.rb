class FactoryMailer < ApplicationMailer
  # Design pattern Factory
  def mail_generator args
    @municipe = args[:municipe]

    if @municipe.receber_emails
      mailer_class = args[:mailer_class]
      mailer_template = args[:mailer_template]
      
      case mailer_class
      when 'factory_mailer'
        mail(
          subject: args[:title],
          to: @municipe.email,
          template_path: mailer_class,
          template_name: mailer_template
        )
      else
        logger.error "CLASS => [#{self.class.name}] | METHOD => [#{self.action_name}] | ERROR => [Nao foi possivel construir um e-mail para a classe #{mailer_class}]"
      end
    end
  end
end