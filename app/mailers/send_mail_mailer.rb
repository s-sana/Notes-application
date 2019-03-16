# frozen_string_literal: true

# Managing the mails
class SendMailMailer < ApplicationMailer
  default from: 'ssana14@gmail.com'

  def signup_email
    @user = params[:user]
    @name = params[:username]
    @noteurl = params[:noteurl]
    @url = 'http://localhost:3000/users/sign_up'

    mail(
      to: @user.email,
      subject: 'Sign up to continue'
    )
  end

  def note_email
    @user = params[:user]
    @name = params[:username]
    @noteurl = params[:noteurl]

    mail(
      to: @user.email,
      subject: 'Note shared'
    )
  end

  def request_edit_email
    @note = params[:note]
    @sender_email = params[:sender_email]
    @receiver_email = params[:receiver_email]
    @noteurl = params[:noteurl]

    mail(
      from: @sender_email,
      to: @receiver_email,
      subject: 'Note edit access'
    )
  end

  def update_edit_request
    @note = params[:note]
    @sender_email = params[:sender_email]
    @receiver_email = params[:receiver_email]
    @noteurl = params[:noteurl]

    mail(
      from: @sender_email,
      to: @receiver_email,
      subject: 'Note edit access granted'
    )
  end
end
