# frozen_string_literal: true

module CONST
  AUTH_CODE_EXP = 3.hours
  CODE_MAX_LENGTH = 6
  DEFAULT_CATE_DEP = 3
  DEFAULT_EXP_TIME = 30.days
  DEFAULT_ICON = 'https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fsymbol_questionmark.png?v=1626855324319'
  DEFAULT_PRODUCT_AMOUNT = 1000
  DEFAULT_PRODUCT_IN_CATE = 10
  DEFAULT_PRODUCT_IMAGE = 'https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fdefault-store-350x350.jpg?v=1626773295200'
  DEFAULT_RELATED_PROJECTS = 10
  OFFSET = 1
  PER_PAGE = 10
  PHONE_NUMBER_REGEX_VALIDATE = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/
  PRODUCT_IN_STOCK = 10
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  MAP_VN = ["ĂăÂâĐđÊêÔôƠơƯưÁáÀàÃãẤấẦầẮắẰằẪẫẴẵẢảẨẩẲẳẠạẬậẶặÉéÈèẼẽẾếỀềỄễẺẻỂểẸẹỆệÍíÌìĨĩỈỉỊịÓóÒòÕõỐốỒồỖỗỎỏỔổỌọỚớỜờỠỡỘộỞởỢợÚúÙùŨũỦủỤụỨứỪừỮữỬửỰựÝýỲỳỸỹỶỷỴỵ",
            "AaAaDdEeOoOoUuAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaEeEeEeEeEeEeEeEeEeEeIiIiIiIiIiOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoUuUuUuUuUuUuUuUuUuUuYyYyYyYyYy"]
end
