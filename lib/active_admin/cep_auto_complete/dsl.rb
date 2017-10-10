module ActiveAdmin
  module CepAutoComplete
    module DSL
      def setup_cep_auto_complete(&block)
        renderer = config.cep_renderer
        renderer.instance_eval(&block) if block_given?

        menu false

        controller do
          require 'postmon_ruby'

          # TODO: Find another to pass down the renderer variable
          @@renderer = renderer

          def index
            if is_cep_valid?
              query = Query.search(parsed_cep)

              if query
                render json: @@renderer.render(query)
              else
                render nothing: true, status: 404
              end
            else
              render nothing: true, status: 404
            end
          end

          def is_cep_valid?
            parsed_cep =~ /\A#{CEP_REGEX_BODY}\z/
          end

          def parsed_cep
            @parsed_cep ||= params[:cep].to_s.gsub(/[^\d]/, '')
          end
        end
      end
    end
  end
end
