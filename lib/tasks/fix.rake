namespace :fix do
  desc "TODO"
  task categories: :environment do
    defaults = [
      { color: Helpers::RandomHelper.color },
      { icon: CONST::DEFAULT_ICON },
      { icon: CONST::DEFAULT_PRODUCT_IMAGE },
      { independent_brand: false },
      { showable: false },
    ]
    defaults.each do |item|
      Category.where(item.keys.last => nil).update_all(item)
    end
  end

  desc "TODO"
  task photos: :environment do
    ids = Photo.search(url: '[').pluck(:id)
    index = 0
    ids.each do |id|
      p = Photo.find(id)
      if p.update(url: "https:#{p.url.scan(/\["([^"]*)"\]/).first.first}")
      index += 1
      end
    end
    puts "@===Fixing Photo===@ [#{index} / #{ids.size}]"
  end

  desc "TODO"
  task banners: :environment do
    Banner.where(name: nil).each_with_index do |b, index|
      b.update(name: "Banner #{index}")
    end
  end

  desc "TODO"
  task slugs: :environment do
    [Product, Banner, Category, FlashSale].each do |model|
      model.all.each do |item|
        item.update(slug: nil)
      end
    end
  end

  desc "TODO"
  task users: :environment do
    Admin.where(active: nil).update_all(active: true)
    User.where(active: nil).update_all(active: true)

    User.all.each do |user|
      user.tap do |u|
        u.dependency
      end.save
    end
  end
end
