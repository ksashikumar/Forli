#AMS adapter
module ActiveModel
  class Serializer
    def json_key
      root
    end
    class CollectionSerializer
      def json_key
        root
      end
    end
  end
end
ActiveModel::Serializer.config.adapter = :json
