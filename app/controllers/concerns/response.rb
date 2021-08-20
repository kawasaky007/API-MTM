# frozen_string_literal: true

class Response
  SYSTEM = {
    INTERNAL_ERRORS: 'Lỗi Nội Bộ'
  }.freeze

  AUTHORIZATION = {
    LOGIN_FAIL: 'Sai Email Hoặc Mật Khẩu ',
    PERMS_DENIED: 'Truy Cập Bị Từ Chối',
    UNAUTH: 'Chưa Xát Thực',
    UNACTIVE: 'Tài Khoản Chưa Được Kích Hoạt',
    AUTH_CODE: 'Mã Xát Thực Đã Hết Hạn'
  }.freeze

  USER = {
    NOT_FOUND: 'Tài Khoản Không Tìm Thấy',
    DELETE_YOUR_SELF: 'Không Thể Xóa Bản Thân',
    WRG_PASSWORD: 'Sai Mật Khẩu',
    SAME_OLD_P: 'Trùng với Mật Khẩu Cũ',
    EMAIL_NOT_FOUND: 'Email Không Tồn Tại'
  }.freeze

  PRODUCT = {
    PRODUCT_IN_STOCK: 'Sản phẩm không đủ'
  }.freeze

  ORDER = {
    NOT_ALLOW_UPDATE: 'Bạn không thể cập nhật đơn hàng khi đã chốt',
    SAVED_PRODUCTS_EMPTY: 'Không có sản phẩm trong giỏ hàng'
  }.freeze

  SALE = {
    VALID_TIME: 'Thời gian không hợp lệ, thời gian kết thúc phải lớn hơn thời gian bắt đầu'
  }.freeze
end

class << Response
  def status_convert(status)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end

  def paginate(
    model,
    per_page,
    page,
    serializer = nil,
    instance_options = {}
  )
    per_page ||= CONST::PER_PAGE
    page ||= CONST::OFFSET

    model = block_given? ? (yield model) : model.all
    count = model.size
    model = model.paginate(per_page: per_page, page: page)

    if serializer
      model = Helpers::SerializerHelpers.each(
        model,
        { each_serializer: serializer }
          .merge(instance_options)
      )
    end

    {
      json: {
        data: model,
        status: status_convert(:ok),
        metadata: {
          count: count,
          page: page,
          per_page: per_page.to_i,
          pages: (count / per_page.to_f).ceil
        }
      },
      status: status_convert(:ok)
    }
  end

  def data(args)
    data = if args[:serializer]
             args[:serializer].new(
               args[:data],
               args.except(:serializer, :data, :status)
             )
           else
             args[:data]
           end

    {
      json: {
        status: status_convert(args[:status] || :ok),
        data: data
      },
      status: status_convert(args[:status] || :ok)
    }
  end

  def messaging(args)
    responses = args[:data]
    responses = responses.values if responses.instance_of?(Hash)
    responses = responses.join('; ') if responses.instance_of?(Array)

    {
      json: {
        status: status_convert(args[:status] || :unprocessable_entity),
        error: responses
      },
      status: status_convert(args[:status] || :unprocessable_entity)
    }
  end

  def success(status = :ok)
    {
      json: {
        status: status_convert(status),
        success: true
      },
      status: status_convert(status)
    }
  end
end
