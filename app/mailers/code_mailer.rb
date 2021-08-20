# frozen_string_literal: true

class CodeMailer < ApplicationMailer
  def code(payload)
    @payload = payload
    mail(to: @payload[:email], subject: '💪 PATITEK | TECH BUY SOTFWARE - Mã Xác Thực Của Bạn')
  end
end
