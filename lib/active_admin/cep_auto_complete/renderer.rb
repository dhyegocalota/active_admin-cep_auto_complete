module ActiveAdmin
  module CepAutoComplete
    class Renderer
      def initialize
        @default_renderers = DEFAULT_FIELDS.map { |field| [field, default_renderer_for(field)] }.to_h.with_indifferent_access
        @custom_renderers = {}.with_indifferent_access
      end

      def field(field_name, &block)
        @custom_renderers[field_name] =
          if block_given?
            block
          else
            default_renderer_for(field_name)
          end
      end

      def render(query)
        [@default_renderers, @custom_renderers].reduce(build_object(query)) do |object, renderers|
          renderers.keys.each do |field|
            value = renderers[field].call(object)
            object.tap { object.public_send("#{field}=", value) }
          end
          object
        end.to_h
      end

      protected

      def default_renderer_for(field)
        ->(cep) { cep.public_send(field) }
      end

      private

      def build_object(query)
        klass.new(*query.values)
      end

      def klass
        Struct.new(:cep, *(@default_renderers.merge(@custom_renderers)).keys)
      end
    end
  end
end
