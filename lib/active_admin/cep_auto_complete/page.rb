module ActiveAdmin
  module CepAutoComplete
    module Page
      def cep_renderer
        @cep_renderer ||= Renderer.new
      end
    end
  end
end
