# Most of this content was picked from an older project I worked with, specially because is easy to read and its reusable
module SerializationConcern
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

    def paginate_response_with_serializer(pagy, results, serializer)
      {
        info: pagy_info(pagy),
        results: ActiveModel::Serializer::CollectionSerializer.new(
          results, serializer: serializer)
      }
    end

    def render_response(result, serializer)
      # I only make a 422 exception for this exam, it can be more complex but its just for the test
      if result.errors.any?
        {
          status: 422,
          message: result.errors
        }
      else
        {
          result: ActiveModelSerializers::SerializableResource.new(
          result, serializer: serializer)
        }
      end
    end
  end
end
