module ActiveAdmin
  module CepAutoComplete
    class Renderer
      def initialize
        @renderers = DEFAULT_FIELDS.map { |field| [field, default_renderer_for(field)] }.to_h.with_indifferent_access
      end

      def field(field_name, &block)
        @renderers[field_name] =
          if block_given?
            block
          else
            default_renderer_for(field_name)
          end
      end

      def render(query)
        object = build_object(query)

        @renderers.keys.map do |field|
          value = @renderers[field].call(object)
          object.public_send("#{field}=", value)
          [field, value]
        end.to_h
      end

      protected

      def default_renderer_for(field)
        lambda { |cep| cep.public_send(field) }
      end

      private

      def build_object(query)
        klass.new(*query.values)
      end

      def klass
        Struct.new(:cep, *@renderers.keys)
      end
    end
  end
end
