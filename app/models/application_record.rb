# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_slug_name(colum)
    slug = attributes[colum.to_s].tr(
      CONST::MAP_VN.first,
      CONST::MAP_VN.last
    ).parameterize

    loop do
      break if self.class.find_by(slug: slug).nil?

      slug += "-#{Helpers::RandomHelper.string}"
    end

    slug
  end

  class << self
    def params_object_or_id(symbol, params)
      tmp = params.slice(
        "#{symbol}_id".to_sym,
        "#{symbol}_id",
        symbol.to_sym,
        symbol.to_s
      ).to_h.first
      { tmp.first => tmp.second }
    end

    def randomly!
      all.order('RANDOM()')
    end

    def find_with_id_or_slug(param)
      if alpha?(param)
        find_by(slug: param)
      else
        find(param)
      end
    end

    def singular_name
      table_name.singularize
    end

    def search(args)
      resource = all
      args.keys.map do |key|
        resource = resource.where(
          "REPLACE(LOWER(#{table_name}.#{key}), ' ', '') like ?",
          "%#{args[key].gsub(' ', '').downcase}%"
        )
      end
      resource
    end

    private

    def alpha?(string)
      string.match(/[[:alpha:]]+/)
    end
  end
end
