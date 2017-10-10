module ActiveAdmin
  module CepAutoComplete
    module Page
      def cep_renderer
        @cep_renderer ||= Renderer.new(self)
      end
    end
  end
end
