# frozen_string_literal: true

def update_thisOne_for(something, something_too)
  puts "--> update `#{something}` for `#{something_too}`"
end

def log_counter(*models)
  puts "[-]->> #{models.map(&:table_name).join(', ')}"
  counter = models.map(&:count)
  yield 
  puts "[#]->> [update: #{models.map(&:count) - counter}]\n\n"
end

log_counter(User, Admin) do
  Admin
    .find_or_initialize_by(email: "admin.test@gmail.com")
    .update(
      full_name: "Admin",
      password: "123456"
    )

  User
    .find_or_initialize_by(email: "user.test@gmail.com")
    .update(
      full_name: "User",
      password: "123456",
      phone_number: "+84846000000",
      sex: "male",
      dob: Time.zone.now,
    )
end

log_counter(Banner) do
  urls = [
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_4.webp?v=1626765811057" },
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_5.webp?v=1626765979634" },
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_3.webp?v=1626765986881" },
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_7.webp?v=1626766012851" },
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_9.webp?v=1626766018542" },
    { url: "https://cdn.glitch.com/c16f71ef-e58b-4291-89f3-62975c2ebc7f%2Fslideshow_10.webp?v=1626766027295" }
  ]

  urls.each_with_index do |url, index|
    Banner.find_or_create_by(url.merge(name: "Banner #{index}"))
  end
end

log_counter(Category, Product) do
  categories = [
    {
      name: 'Trang chủ', url: '/',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_1_2.png?v=307',
      photo: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_1_1.png?v=307',
    },
    {
      name: 'Mẹ & Bé', url: 'https://methongminh.com.vn/collections/do-choi-me-be',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_2_1.png?v=307',
      photo: 'https://static2.yan.vn/YanNews/2167221/201805/thich-thu-voi-bo-tranh-ve-lai-cuoc-song-thuong-nhat-cua-mot-me-bim-sua-86f088b8.jpg',
      children_attributes: [
        {
          name: 'Combo tiết kiệm', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-me-be',
          photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-1.jpg?v=307',
          children_attributes: [
            { 
              name: 'Tã bỉm em bé', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-ta-em-be-drypers',
            },
            { 
              name: 'Sữa dinh dưỡng', url: 'https://methongminh.com.vn/collections/sua-dinh-duong',
            },
            { 
              name: 'Dầu gội, sữa tắm trẻ em',  url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-dau-goi-sua-tam-tre-em',
            },
            { 
              name: 'Đồ chơi', url: 'https://methongminh.com.vn/collections/do-choi-1',
            },
          ],
        },
        {
          name: 'Tã Bỉm Drypers Châu Âu', url: 'https://methongminh.com.vn/collections/san-pham-drypers-chau-au',
          photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-2.jpg?v=307',
        },
        { 
          name: 'Tã Bỉm Nội địa Hàn Quốc Cooing', url: 'https://methongminh.com.vn/collections/ta-cooing',
        },
        { 
          name: 'Sữa dinh dưỡng', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-sua-dinh-duong',
        },
        { 
          name: 'Dầu gội, sữa tắm', url: 'https://methongminh.com.vn/collections/dau-goi-sua-tam-1',
        },
        { 
          name: 'Đồ chơi trẻ em', url: 'https://methongminh.com.vn/collections/do-choi-1',
        },
      ]
    },
    {
      name: 'Người cao tuổi', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-nguoi-cao-tuoi',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_4_1.png?v=307',
      photo: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_4_2.png?v=307',
      children_attributes: [
        {
          name: 'Combo tiết kiệm', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-nguoi-cao-tuoi',
          photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-1.jpg?v=307',
          children_attributes: [
            {
              name: 'Tã bỉm người lớn', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-ta-nguoi-lon-tena',
              photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-4.jpg?v=307',
            },
            { 
              name: 'Sữa đặc trị', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-sua-dac-tri',
            },
            { 
              name: 'Kem dưỡng đặc trị', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-kem-dac-tri',
            },
          ],
        },
        { 
          name: 'Tã bỉm người lớn', url: 'https://methongminh.com.vn/collections/ta-nguoi-lon-tena',
        },
        { 
          name: 'Sữa đặc trị', url: 'https://methongminh.com.vn/collections/sua-dac-tri',
        },
        {
          name: 'Kem dưỡng đặc trị', url: 'https://methongminh.com.vn/collections/kem-duong-dac-tri',
        }
      ]
    },
    {
      name: 'Bách hoá tiêu dùng', url: 'https://methongminh.com.vn/collections/hang-tieu-dung',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_3_1.png?v=307',
      photo: 'https://media.shoptretho.com.vn/upload/image/news/day-co-biet-yeu-thuobng.jpg',
      children_attributes: [
        {
          name: 'Combo tiết kiệm', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-bach-hoa-tieu-dung-online',
          photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-1.jpg?v=307',
          children_attributes: [
            { 
              name: 'Thức uống', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-keo-ngam-khong-duong-impact-mints',
            },
            { 
              name: 'Sản phẩm từ giấy', url: 'https://methongminh.com.vn/collections/san-pham-tu-giay',
            },
            { 
              name: 'Gạo - ngũ cốc cao cấp', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-gao-ngu-coc-cao-cap',
            },
            { 
              name: 'Gia vị cho mẹ', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-gia-vi-cho-me',
            },
          ]
        },
        {
          name: 'Kẹo Bạc hà Không Đường Impact Mints' , url: 'https://methongminh.com.vn/collections/keo-bac-ha-khong-duong-tu-duc',
          photo: 'https://theme.hstatic.net/1000403134/1000595209/14/banner-index-3.jpg?v=307' ,
        },
        { 
          name: 'Sản phẩm từ giấy', url: 'https://methongminh.com.vn/collections/combo-tiet-kiem-san-pham-tu-giay',
        },
        { 
          name: 'Bánh kẹo &amp; thức uống thảo dược', url: 'https://methongminh.com.vn/collections/banh-keo-tra-thao-duoc',
        },
        { 
          name: 'Gạo - ngũ cốc cao cấp', url: 'https://methongminh.com.vn/collections/gao-ngu-coc-cao-cap',
        },
        { 
          name: 'Gia vị cho mẹ', url: 'https://methongminh.com.vn/collections/gia-vi-cho-me',
        },
      ]
    },
    {
      name: 'Thời trang - Làm đẹp', url: 'https://methongminh.com.vn/collections/thoi-trang-lam-dep',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_5_1.png?v=307',
      photo: 'https://mdec.vn/wp-content/uploads/2019/11/thi%E1%BA%BFt-k%E1%BA%BF-th%E1%BB%9Di-trang.jpg',
      children_attributes: []
    },
    {
      name: 'Đồ dùng Gia đình Không Điện', url: 'https://methongminh.com.vn/collections/do-dung-gia-dinh-khong-dien',
      icon: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_6_2.png?v=307',
      photo: 'https://theme.hstatic.net/1000403134/1000595209/14/slider_index_link_6_1.png?v=307',
      children_attributes: [
        { 
          name: 'Khuyến mãi nổi bật trong tháng', url: 'https://methongminh.com.vn/collections/frontpage',
        },
        { 
          name: 'Chăm sóc Nhà Bếp', url: 'https://methongminh.com.vn/collections/do-dung-gia-dinh-khong-dien',
        },
        { 
          name: 'Chăm sóc Phòng Khách', url: 'https://methongminh.com.vn/collections/cham-soc-phong-khach',
        },
        { 
          name: 'Chăm sóc Phòng Ngủ', url: 'https://methongminh.com.vn/collections/cham-soc-phong-ngu',
        },
        { 
          name: 'Chăm sóc Nhà Tắm', url: 'https://methongminh.com.vn/collections/cham-soc-nha-tam',
        },
        { 
          name: 'Khác', url: 'https://methongminh.com.vn/collections/khac',
        },
      ]
    },
  ]

  break unless Category.count.zero?

  categories.each do |category|
    cate = Category.find_or_initialize_by(name: category[:name])
    if cate.updated_at.nil?
      cate.update(category) unless category[:name] == 'Trang chủ'
    end
  end
  Category.all.each do |category|
    if category.products.count.zero?
      puts "--> update products for `#{category.name}`"
      category.import_from_url 
    end
  end
end

log_counter(FlashSale) do
  FlashSale.create(
    name: 'Siêu đại hạ giá nhân mùa "Cô Dích"',
    active_time: Date.today.to_datetime,
    expired_time: (Date.today + 356).to_datetime
  ) if FlashSale.where('expired_time > ?', Time.now).count.zero?

  FlashSale.create(
    name: 'FREE SHIP TO HANOI AND HOCHIMINH',
    photo: 'https://drive.google.com/uc?id=1kM0dvzkr8Dek6uzUUayb9NyOVsiq04xV&export=download',
    popup: true,
    active_time: Date.today.to_datetime,
    expired_time: (Date.today + 356).to_datetime
  ) if FlashSale.where(
    'popup is true and active_time <= ? and ? <= expired_time',
    *([Time.zone.now])*2
  ).count.zero?
end

log_counter(Product) do
  Product.all.each do |product|
    product.create_current_flash_sale_detail(
      limit_per_user: 10,
      total: 100,
      active: true,
      discount: product.discount,
      flash_sale: FlashSale.first
      # ) if !product.discount.zero?
    ) if !product.discount.zero? && product.flash_sale_detail_id.nil?
  end
end

log_counter(Category, Product) do
  [
    # Me & Be
    {
      parent: 'Mẹ & Bé',
      independent_brand: true,
      name: "Drypers Wee Wee Dry",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3E0)%26%26((vendor%3Aproduct**Drypers%20Wee%20Wee%20Dry)))&view=filter",
      photo: "https://www.shopifull.com/wp-content/uploads/2020/05/Dryper-wee-wee-dry-L62.jpg"
    },
    {
      parent: 'Mẹ & Bé',
      independent_brand: true,
      name: "Cooing",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3E0)%26%26((vendor%3Aproduct**Cooing)))&view=filter",
      photo: "https://cf.shopee.vn/file/2ab45be583d4f22df69e7dfa403326ca"
    },
    {
      parent: 'Mẹ & Bé',
      independent_brand: true,
      name: "Drypers Touch",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3E0)%26%26((vendor%3Aproduct**Drypers%20Touch)))&view=filter",
      photo: "https://salt.tikicdn.com/cache/w444/ts/product/d5/39/a4/c07530bc20f94d8a938ac0534a015f38.jpg"
    },
    # Nguoi Cao tuoi
    {
      parent: 'Người cao tuổi',
      independent_brand: true,
      name: "Tena Pants Value",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001949307)%26%26((vendor%3Aproduct**Tena%20Pants%20Value)))&view=filter",
      photo: "https://salt.tikicdn.com/cache/w1200/ts/product/0a/8f/3d/ac64ffbb6ad97cd6abbb411a0e8af4bb.jpg"
    },
    {
      parent: 'Người cao tuổi',
      independent_brand: true,
      name: "Tena Pants",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001949307)%26%26((vendor%3Aproduct**Tena%20Value)))&view=filter",
      photo: "https://www.smartlifetime.com/images/detailed/13/tena-proskin-pants-super-xl-change-mobile-protection-incontinence-smartlifetime.jpg"
    },
    {
      parent: 'Người cao tuổi',
      independent_brand: true,
      name: "Tena",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001949307)%26%26((vendor%3Aproduct**Tena)))&view=filter",
      photo: "https://tena-images.essity.com/images-c5/694/259694/optimized-AzurePNG2K/tena-slip-junior-32-int.png?w=1600&h=500&imPolicy=dynamic"
    },
    # Bach Hoa Tieu Dung
    {
      parent: 'Bách hoá tiêu dùng',
      independent_brand: true,
      name: "Impact Mints",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001999067)%26%26((vendor%3Aproduct**Impact%20Mints)))&view=filter",
      photo: "https://m.media-amazon.com/images/S/aplus-media/vc/785a70d5-26dd-4489-94c7-5904bba0966d.__CR0,0,970,600_PT0_SX970_V1___.jpg"
    },
    {
      parent: 'Bách hoá tiêu dùng',
      independent_brand: true,
      name: "Tempo Softpack Neutral",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001999067)%26%26((vendor%3Aproduct**Tempo%20Softpack%20Neutral)))&view=filter",
      photo: "https://salt.tikicdn.com/cache/550x550/ts/product/9a/bf/0d/a4370773ed5b607b9944915f342e5fbc.jpg"
    },
    {
      parent: 'Bách hoá tiêu dùng',
      independent_brand: true,
      name: "Boganic",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001999067)%26%26((vendor%3Aproduct**Boganic)))&view=filter",
      photo: "https://nhathuocthanhbinh.net/wp-content/uploads/2019/06/bo-gan-boganic.jpg"
    },
    # Do Dung Gia Dinh Khong Dien
    {
      parent: 'Đồ dùng Gia đình Không Điện',
      independent_brand: true,
      name: "Myjae",
      url: "https://methongminh.com.vn/search?q=filter=((collectionid%3Aproduct%3D1001939633)%26%26((vendor%3Aproduct**Myjae)))&view=filter",
      photo: "https://cf.shopee.vn/file/1a89edf92c7c11bbac1e6818d1431499"
    },
  ].each do |cate|
    category = Category.find_or_initialize_by(name: cate[:name])
    break unless Category.count.zero?

    parent = Category.find_by(name: cate[:parent])
    cate[:parent_id] = parent.id if cate
    category.update(cate.except(:parent))

    if category.updated_at.nil?
      update_thisOne_for('products', category.name)
      category.import_from_url 
      category.save
    end
  end
end

log_counter(Transport) do
  Transport.create([
    # GIAO HAN TIET KIEM
    { name: 'Tây Bắc Bộ', region: 'Lào Cai, Yên Bái, Điện Biên, Hoà Bình, Lai Châu, Sơn La, ', price: 180_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Đông Bắc bộ', region: 'Hà Giang, Cao Bằng, Bắc Kạn, Lạng Sơn, Tuyên Quang, Thái Nguyên, Phú Thọ, Bắc Giang, Quảng Ninh, ', price: 180_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Đồng bằng sông Hồng', region: 'Bắc Ninh, Hà Nam, Hà Nội, Hải Dương, Hải Phòng, Hưng Yên, Nam Định, Ninh Bình, Thái Bình, Vĩnh Phúc, ', price: 150_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Bắc Trung Bộ', region: 'Thanh Hóa, Nghệ An, Hà Tĩnh, Quảng Bình, Quảng Trị, Thừa Thiên Huế, ', price: 120_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Nam Trung Bộ', region: 'Đà Nẵng, Quảng Nam, Quảng Ngãi, Bình Định, Phú Yên, Khánh Hòa, Ninh Thuận, Bình Thuận, ', price: 80_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Tây Nguyên', region: 'Kon Tum, Gia Lai, Đắk Lắk, Đắk Nông, Lâm Đồng, ', price: 50_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Vùng Đông Nam Bộ', region: 'Bình Phước, Bình Dương, Đồng Nai, Tây Ninh, Bà Rịa - Vũng Tàu, ', price: 20_000, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Nội Thành', region: 'Hồ Chí Minh', price: 0, transport_method: 'Giao Hàng Tiết Kiệm' },
    { name: 'Vùng đồng bằng sông Cửu Long', region: 'Long An, Đồng Tháp, Tiền Giang, An Giang, Bến Tre, Vĩnh Long, Trà Vinh, Hậu Giang, Kiên Giang, Sóc Trăng, Bạc Liêu, Cà Mau, Cần Thơ, ', price: 20_000, transport_method: 'Giao Hàng Tiết Kiệm' },

    { name: 'Tây Bắc Bộ', region: 'Lào Cai, Yên Bái, Điện Biên, Hoà Bình, Lai Châu, Sơn La, ', price: 200_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Đông Bắc bộ', region: 'Hà Giang, Cao Bằng, Bắc Kạn, Lạng Sơn, Tuyên Quang, Thái Nguyên, Phú Thọ, Bắc Giang, Quảng Ninh, ', price: 200_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Đồng bằng sông Hồng', region: 'Bắc Ninh, Hà Nam, Hà Nội, Hải Dương, Hải Phòng, Hưng Yên, Nam Định, Ninh Bình, Thái Bình, Vĩnh Phúc, ', price: 180_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Bắc Trung Bộ', region: 'Thanh Hóa, Nghệ An, Hà Tĩnh, Quảng Bình, Quảng Trị, Thừa Thiên Huế, ', price: 140_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Nam Trung Bộ', region: 'Đà Nẵng, Quảng Nam, Quảng Ngãi, Bình Định, Phú Yên, Khánh Hòa, Ninh Thuận, Bình Thuận, ', price: 100_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Tây Nguyên', region: 'Kon Tum, Gia Lai, Đắk Lắk, Đắk Nông, Lâm Đồng, ', price: 80_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Vùng Đông Nam Bộ', region: 'Bình Phước, Bình Dương, Đồng Nai, Tây Ninh, Bà Rịa - Vũng Tàu, ', price: 50_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Nội Thành', region: 'Hồ Chí Minh', price: 20_000, transport_method: 'Giao Hàng Nhanh' },
    { name: 'Vùng đồng bằng sông Cửu Long', region: 'Long An, Đồng Tháp, Tiền Giang, An Giang, Bến Tre, Vĩnh Long, Trà Vinh, Hậu Giang, Kiên Giang, Sóc Trăng, Bạc Liêu, Cà Mau, Cần Thơ, ', price: 50_000, transport_method: 'Giao Hàng Nhanh' },
  ]) if Transport.count.zero?
end
