module PaginationConcern
  extend ActiveSupport::Concern

  included do
    def paginate_response(pagy,results)
      {
        info: pagy_info(pagy), results: results
      }
    end

    def pagy_info(pagy)
      {
        page_size: pagy.vars[:"items"].to_i,
        page_index: pagy.page,
        total: pagy.count,
        page_start: pagy.from,
        page_end: pagy.to,
        pages_total: pagy.pages
      }
    end

    def paginate_response_with_serializer(pagy, results, serializer, options: {})
      {
        info: pagy_info(pagy),
        results: ActiveModel::Serializer::CollectionSerializer.new(
          results, serializer: serializer, **options)
      }
    end
  end
end
